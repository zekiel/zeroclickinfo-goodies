package DDG::Goodie::GoodieTemplateCustom;
# ABSTRACT: Test custom templates with Goodies 

use Lingua::EN::Numbers::Ordinate;
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
zci is_cached   => 0;

handle remainder => sub {
  my $in = shift;

  return unless $in;

  my @numeric_values = map{{char => $_, val => ord}} (split '', $in);

  my %answers = (
	text =>	{
    	data => {
    		title => html_enc(join('_', split('', $in))),
    		subtitle => html_enc($in), 
    	 	description => 'We split and rejoined with underscores!',
			numeric_values => \@numeric_values,,
			image => 'https://duck.co/ddgc_static/img/logo_ddg_duckduckhack.png'
    	},
    	templates => {
			group => 'info',
           	options => {
		    	content => 'DDH.goodie_template_custom.content',
			    aux => 'DDH.goodie_template_custom.aux',
			    moreAt => 1 
		    }
    	}
    }
  );

  my $answer = $answers{text};

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
