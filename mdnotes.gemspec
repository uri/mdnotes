Gem::Specification.new do |s|
  s.name        = 'mdnotes'
  s.version     = '0.1.7'
	s.executables << 'mdnotes'
  s.summary     = "Suite for taking easy notes in markdown and then converting to html and pdf."
  s.description = "Suite for taking easy notes in markdown and then converting to html and pdf."
  s.authors     = ["Uri Gorelik"]
  s.email       = 'uri.gore@gmail.com'
  s.files       = ["lib/mdnotes.rb"]
  s.homepage    = 'https://bitbucket.org/ugorelik/mdnotes'
	s.requirements << 'rdiscount'
	s.requirements << 'pdfkit'
	s.add_runtime_dependency 'rdiscount'
	s.add_runtime_dependency 'pdfkit'
end