import 'dart:html';
import 'package:http/browser_client.dart';

// curl https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc

void main() {
  // Selectors
  var title = querySelector('#title');
  var popularLanguages = querySelector('#popular-languages');
  var otherLanguages = querySelector('#other-languages');
  InputElement searchText = querySelector('#search-text');
  ButtonElement searchBtn = querySelector('#search-btn');
  SelectElement languageFilter = querySelector('#search-language');

  // Set title
  title.text = 'GitHub Search ✨';

  // Add languages
  popularLanguages.setInnerHtml(getPopularLanguagesHTML());
  otherLanguages.setInnerHtml(getOtherLanguagesHTML());

  // Add listeners
  searchBtn.addEventListener('click', (evt) async {
    evt.preventDefault();

    if (searchText.value == '') {
      print('Error: Search input is empty.');
      return;
    }

    StringBuffer sb = new StringBuffer();
    sb.write('https://api.github.com/search/repositories?');

    if (languageFilter.value != '') {
      sb.write('l=${languageFilter.value}');
      sb.write('&q=${searchText.value}');
    } else {
      sb.write('q=${searchText.value}');
    }

    sb.write('&type=Repositories');

    // Start search
    search(sb.toString());

    // Clean search input
    searchText.value = '';
  });
}

String getPopularLanguagesHTML() {
  List<String> popularLanguagesList = ['ActionScript','C','C#','C++','Clojure','CoffeeScript','CSS','Go','Haskell','HTML','Java','JavaScript','Lua','MATLAB','Objective-C','Perl','PHP','Python','R','Ruby','Scala','Shell','Swift','TeX','Vim script'];

  StringBuffer sb = new StringBuffer();

  for (var lang in popularLanguagesList) {
    sb.write('<option value="${lang}">${lang}</option>');
  }

  return sb.toString();
}

String getOtherLanguagesHTML() {
  List<String> otherLanguagesList = ['1C Enterprise','ABAP','ABNF','Ada','Adobe Font Metrics','Agda','AGS Script','Alloy','Alpine Abuild','AMPL','AngelScript','Ant Build System','ANTLR','ApacheConf','Apex','API Blueprint','APL','Apollo Guidance Computer','AppleScript','Arc','AsciiDoc','ASN.1','ASP','AspectJ','Assembly','ATS','Augeas','AutoHotkey','AutoIt','Awk','Ballerina','Batchfile','Befunge','Bison','BitBake','Blade','BlitzBasic','BlitzMax','Bluespec','Boo','Brainfuck','Brightscript','Bro','C-ObjDump','C2hs Haskell','Cap\'n Proto','CartoCSS','Ceylon','Chapel','Charity','ChucK','Cirru','Clarion','Clean','Click','CLIPS','Closure Templates','Cloud Firestore Security Rules','CMake','COBOL','ColdFusion','ColdFusion CFC','COLLADA','Common Lisp','Common Workflow Language','Component Pascal','CoNLL-U','Cool','Coq','Cpp-ObjDump','Creole','Crystal','CSON','Csound','Csound Document','Csound Score','CSV','Cuda','CWeb','Cycript','Cython','D','D-ObjDump','Darcs Patch','Dart','DataWeave','desktop','Diff','DIGITAL Command Language','DM','DNS Zone','Dockerfile','Dogescript','DTrace','Dylan','E','Eagle','Easybuild','EBNF','eC','Ecere Projects','ECL','ECLiPSe','Edje Data Collection','edn','Eiffel','EJS','Elixir','Elm','Emacs Lisp','EmberScript','EML','EQ','Erlang','F#','F*','Factor','Fancy','Fantom','FIGlet Font','Filebench WML','Filterscript','fish','FLUX','Formatted','Forth','Fortran','FreeMarker','Frege','G-code','Game Maker Language','GAMS','GAP','GCC Machine Description','GDB','GDScript','Genie','Genshi','Gentoo Ebuild','Gentoo Eclass','Gerber Image','Gettext Catalog','Gherkin','GLSL','Glyph','Glyph Bitmap Distribution Format','GN','Gnuplot','Golo','Gosu','Grace','Gradle','Grammatical Framework','Graph Modeling Language','GraphQL','Graphviz (DOT)','Groovy','Groovy Server Pages','Hack','Haml','Handlebars','HAProxy','Harbour','Haxe','HCL','HiveQL','HLSL','HTML+Django','HTML+ECR','HTML+EEX','HTML+ERB','HTML+PHP','HTML+Razor','HTTP','HXML','Hy','HyPhy','IDL','Idris','IGOR Pro','Inform 7','INI','Inno Setup','Io','Ioke','IRC log','Isabelle','Isabelle ROOT','J','Jasmin','Java Properties','Java Server Pages','JFlex','Jison','Jison Lex','Jolie','JSON','JSON with Comments','JSON5','JSONiq','JSONLD','JSX','Julia','Jupyter Notebook','KiCad Layout','KiCad Legacy Layout','KiCad Schematic','Kit','Kotlin','KRL','LabVIEW','Lasso','Latte','Lean','Less','Lex','LFE','LilyPond','Limbo','Linker Script','Linux Kernel Module','Liquid','Literate Agda','Literate CoffeeScript','Literate Haskell','LiveScript','LLVM','Logos','Logtalk','LOLCODE','LookML','LoomScript','LSL','M','M4','M4Sugar','Makefile','Mako','Markdown','Marko','Mask','Mathematica','Maven POM','Max','MAXScript','MediaWiki','Mercury','Meson','Metal','MiniD','Mirah','Modelica','Modula-2','Modula-3','Module Management System','Monkey','Moocode','MoonScript','MQL4','MQL5','MTML','MUF','mupad','Myghty','NCL','Nearley','Nemerle','nesC','NetLinx','NetLinx+ERB','NetLogo','NewLisp','Nextflow','Nginx','Nim','Ninja','Nit','Nix','NL','NSIS','Nu','NumPy','ObjDump','Objective-C++','Objective-J','OCaml','Omgrofl','ooc','Opa','Opal','OpenCL','OpenEdge ABL','OpenRC runscript','OpenSCAD','OpenType Feature File','Org','Ox','Oxygene','Oz','P4','Pan','Papyrus','Parrot','Parrot Assembly','Parrot Internal Representation','Pascal','Pawn','Pep8','Perl 6','Pic','Pickle','PicoLisp','PigLatin','Pike','PLpgSQL','PLSQL','Pod','Pod 6','PogoScript','Pony','PostCSS','PostScript','POV-Ray SDL','PowerBuilder','PowerShell','Processing','Prolog','Propeller Spin','Protocol Buffer','Public Key','Pug','Puppet','Pure Data','PureBasic','PureScript','Python console','Python traceback','q','QMake','QML','Quake','Racket','Ragel','RAML','Rascal','Raw token data','RDoc','REALbasic','Reason','Rebol','Red','Redcode','Regular Expression','Ren\'Py','RenderScript','reStructuredText','REXX','RHTML','Ring','RMarkdown','RobotFramework','Roff','Rouge','RPC','RPM Spec','RUNOFF','Rust','Sage','SaltStack','SAS','Sass','Scaml','Scheme','Scilab','SCSS','sed','Self','ShaderLab','ShellSession','Shen','Slash','Slice','Slim','Smali','Smalltalk','Smarty','SMT','Solidity','SourcePawn','SPARQL','Spline Font Database','SQF','SQL','SQLPL','Squirrel','SRecode Template','Stan','Standard ML','Stata','STON','Stylus','SubRip Text','SugarSS','SuperCollider','SVG','SystemVerilog','Tcl','Tcsh','Tea','Terra','Text','Textile','Thrift','TI Program','TLA','TOML','Turing','Turtle','Twig','TXL','Type Language','TypeScript','Unified Parallel C','Unity3D Asset','Unix Assembly','Uno','UnrealScript','UrWeb','Vala','VCL','Verilog','VHDL','Visual Basic','Volt','Vue','Wavefront Material','Wavefront Object','wdl','Web Ontology Language','WebAssembly','WebIDL','Windows Registry Entries','wisp','World of Warcraft Addon Data','X BitMap','X Font Directory Index','X PixMap','X10','xBase','XC','XCompose','XML','Xojo','XPages','XProc','XQuery','XS','XSLT','Xtend','Yacc','YAML','YANG','YARA','YASnippet','Zephir','Zimpl'];

  StringBuffer sb = new StringBuffer();

  for (var lang in otherLanguagesList) {
    sb.write('<option value="${lang}">${lang}</option>');
  }

  return sb.toString();
}

void search(url) async {
  var client = new BrowserClient();
  var response = await client.get(url);

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
}
