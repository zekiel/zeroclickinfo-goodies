package DDG::Goodie::GoodieTemplateV3;
# ABSTRACT: Test Spice templates with Goodies 

use DDG::Goodie;

primary_example_queries 'gtemplatev3 something';
description 'Test out Spice Templating from Gooides';
name 'GoodieTemplateV3';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/GoodieTemplateV3.pm';
category 'transformations';
topics 'words_and_games';

attribution github => ['https://github.com/zachthompson', 'Zach Thompson'];

triggers startend => 'gtemplatev3';

zci answer_type => 'gtemplatev3';
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
    		subtitle => html_enc($in), 
    	 	description => 'We split and rejoined with pipes!'
    	},
    	templates => {
			group: 'base',
           	options:{
		    	content: Goodie.goodie_template_v3.content,
			    moreAt: true
		    }
    	}
    }
  );

  my $answer = exists $answers{$tmpl} ? $answers{$tmpl} : $answers{text};

  return "You gave gtemplatev3 $in and like HTML!", 
      structured_answer => {
    	  id => 'goodie_template_v3',
    	  name => 'Software',
		  meta => {
			sourceName => 'duckduckgo.com',
			sourceUrl => 'http://duckduckgo.com'
		  },
		  %$answer
	  };
};

1;
