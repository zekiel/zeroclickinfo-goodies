package DDG::Goodie::GoodieTemplateCustom;
# ABSTRACT: Test customtemplates with Goodies 

use DDG::Goodie;

primary_example_queries 'gtc something';
description 'Test out custom handlebars templating from Gooides';
name 'GoodieTemplateCustom';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoodieTemplateCustom.pm';
category 'transformations';
topics 'words_and_games';

attribution github => ['https://github.com/zachthompson', 'Zach Thompson'];

triggers startend => 'gtc';

zci answer_type => 'gtc';
zci is_cached   => 1;

handle remainder => sub {
  my $in = shift;

  return unless $in;

  my ($tmpl, @in) = split /\s+/, $in;
  my $input = "@in";
  my @tiled_input = map {split '', $_} @in;

  my %answers = (
	text =>	{
    	data => {
    		title => html_enc(join('|', split('', $in))),
    		subtitle => $in, 
    	 	description => 'We split and rejoined with pipes!'
    	},
    	templates => {
			group => 'base',
           	options => {
		    	content => 'DDH.goodie_template_custom.content',
			    moreAt => true
		    }
    	}
    }
  );

  my $answer = exists $answers{$tmpl} ? $answers{$tmpl} : $answers{text};

  return "You gave goodie_template_custom $in and like HTML!", 
      structured_answer => {
    	  id => 'goodie_template_custom',
    	  name => 'Software',
		  meta => {
			sourceName => 'duckduckgo.com',
			sourceUrl => 'http://duckduckgo.com'
		  },
		  %$answer
	  };
};

1;
