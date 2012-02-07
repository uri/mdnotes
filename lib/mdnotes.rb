require 'rdiscount'
class MDNotes
	# Params

	def initialize
		@first_setup = false
		@notes = Dir['./md/*.md']
		@pwd = Dir::pwd;
		@publishing = false

		@params = {}

		# Set the params
		ARGV.each do |arg|
			cur_arg = arg.tr "-", ""
			@params[cur_arg] = true
		end
	end

	# Check if directory is ready

	def check_directories
		missing_dirs = {}

		['pdf','html', 'md', 'html/images'].each do |f|
			cur_dir = "./" + f
			curr_dir_exists = FileTest::directory?(cur_dir) 
			missing_dirs[f] = curr_dir_exists
			@first_setup ||= curr_dir_exists
		end

		# Make the name meaningful
		@first_setup = !@first_setup

		if @first_setup
			puts "Detecting first time setup..."
		end

		# Create the mssign directories
		create_directories missing_dirs
	end

	def create_directories dirs
		dirs.each_pair do |k,v|

			cur_dir = @pwd + "/" + k

			if (!v)
				Dir::mkdir(cur_dir) 
				puts "Creating directory #{k}..."
			end
		end
	end




	def compile_notes
		if !@first_setup
			@notes.each do |n|
				name = n.split('/')[-1].split('.')[0]

				puts "Compiling #{name}..."

				raw = open(n).read
				md = RDiscount.new raw
				out = md.to_html
				open("./html/#{name}.html", "w").write out
			end

		end
		puts "Notes compiled."
	end


	def publish_notes
		require 'fileutils'
		require 'pdfkit'
		
		publishing = (@params['p'] || @params['publish'])

		if publishing
			pdf_home = "./pdf"
			Dir::mkdir(pdf_home) unless FileTest::directory?(pdf_home)	

			Dir["./html/*.html"].each do |html|

				f_name = html.split("/")[-1].split(".")[0]
				output_file = File.join(".", "pdf", f_name + ".pdf")
				html_file = File.open(html, 'r') { |f| f.read }

				# Delete the file first.
				FileUtils.rm output_file if FileTest.exists? output_file

				puts "Publishing #{f_name}..."
				
				kit = PDFKit.new(html_file, :page_size => 'Letter')
				kit.to_file(output_file)
			end
			puts "Notes published."
		end

	end


	def start
		if @params['h'] || @params['help']
			puts
			puts
			puts "MDNotes"
			puts "======="
			puts
			puts "Using a terminal, [cd] into the directory you want to takes notes."
			puts "Use command [mdnotes] to create a notes directory."
			puts "Create your markdown (.md) in the md/ directory."
			puts "Use [mdnotes] to 'compile' your notes into html. These will be located in the html/ folder."
			puts "Use [mdnotes -p] or [mdnotes --publish] to create PDFs of your notes. These will be located in the pdf/ folder"
			puts "If you want to include images in your notes you can place them in the images folder located under ./html/images. Use ![alt-text](./images/my_image.png) to reference an image."
			puts
			puts "You can find this at http://bitbucket.org/ugorelik/mdnotes" 
			puts
		else
			check_directories
			compile_notes
			publish_notes
		end
	end
	
end


# MDNotes.new.start #=> local debug


