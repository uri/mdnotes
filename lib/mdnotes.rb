require 'rdiscount'

# Params

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
	publishing = (@params['p'] || @params['publish']) && (require 'pdfkit')

	if publishing
		pdf_home = "./pdf"
		Dir::mkdir(pdf_home) unless FileTest::directory?(pdf_home)	

		Dir["./html/*.html"].each do |html|
			f_name = html.split("/")[-1].split(".")[0]

			html_file = open(html).read

			puts "Publishing #{f_name}..."
			kit = PDFKit.new(html_file, :page_size => 'Letter')
			kit.to_file(		File.join(".", "pdf", f_name + ".pdf"))
		end
	puts "Notes published."
	end

end


check_directories
compile_notes
publish_notes

