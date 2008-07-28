require 'fileutils'
require 'pp'
require 'rubygems'
require 'builder'
require 'rdiscount'
require "uv"

desc 'Create the HTML version'
task :html => :merge do
  if File.exists?('output/full_book.markdown')
    output = File.new('output/full_book.markdown').read
    output = RDiscount.new(output).to_html

    ## pdf version ##
    
    # code highlighting
    File.open('output/index.html', 'w') do |f|
      html_template = File.new("layout/pdf_template.html").read
      html_template.gsub!("#body", output)
      html_template.gsub! /<pre><code>.*?<\/code><\/pre>/m do |code|
        code = code.gsub('<pre><code>', '').gsub('</code></pre>', '').gsub('&lt;', '<').gsub('&gt;', '>').gsub('&amp;', '&')
        Uv.parse(code, "xhtml", "ruby", false, "mac_classic")
      end
      f.puts html_template
    end
    
    ## html version ##
    
    html_dir = 'output/book'
    FileUtils.rm_r(html_dir) rescue nil
    Dir.mkdir(html_dir)
    
    # html chapters
    links = []
    chapter_files = []
    
    count = 0
    sections = output.split('<h1>')
    sections.each do |section|
      # extract title
      title, section = section.split('</h1>')
      next if !section
      count += 1
      title = count.to_s + '. ' + title.strip
      puts title
      
      chlinks = []
      chapters = section.split('<h2>')
      chapters.shift
      chapters.each do |chapter|
        chtitle, chapter = chapter.split('</h2>')
        next if !chapter
        # extract chapter title
        puts "\t" + chtitle.strip
        filename = count.to_s + '_' + chtitle.strip.downcase.gsub(' ', '_') + '.html'
        body = "<h2>#{chtitle}</h2>" + chapter
        chlinks << [chtitle.strip, filename]
        chapter_files << [chtitle.strip, filename, body]
      end
      links << [title.strip, chlinks]
    end

    # writing out the chapter files
    chapter_files.each_with_index do |arr, index|
      chapter_title, chapter_file, body = arr
      File.open(File.join(html_dir, chapter_file), 'w') do |f|
        nav = ''
        if (cf = chapter_files[index - 1]) && index != 0
          nav += "<a href=\"#{cf[1]}\">Prev</a> "
        end
        if cf = chapter_files[index + 1]
          nav += " <a href=\"#{cf[1]}\">Next</a>"
        end
        html_template = File.new("layout/chapter_template.html").read
        html_template.gsub!("#title", chapter_title)
        html_template.gsub!("#body", body)
        html_template.gsub!("#nav", nav)
        f.puts html_template
      end
    end
    
    toc = Builder::XmlMarkup.new(:indent => 1)
    toc.table { toc.tr { 
      toc.td(:valign => "top") {
        links[0,4].each do |section_title, section_array|
          toc.h3(:class => 'title') { toc << section_title }
          toc.table do
            section_array.each do |chapter_title, chapter_file|
              toc.tr { toc.td {
                toc.a(:href => chapter_file, :class => 'chapter-link') << chapter_title
              }}
            end
          end
        end
      }
      toc.td(:valign => "top") {
        links[4,3].each do |section_title, section_array|
          toc.h3(:class => 'title') { toc << section_title }
          toc.table do
            section_array.each do |chapter_title, chapter_file|
              toc.tr { toc.td {
                toc.a(:href => chapter_file, :class => 'chapter-link') << chapter_title
              }}
            end
          end
        end
      }
    }}    
    File.open('output/book/index.html', 'w') do |f|
      html_template = File.new("layout/book_index_template.html").read
      html_template.gsub!("#body", toc.to_s)
      f.puts html_template
    end
    
    `cp -Rf assets/* output/book/`
    
  end
end