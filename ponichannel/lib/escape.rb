# Nora escape
# Copyright(c) 2002 MoonWolf <moonwolf@moonwolf.com>
begin
  require "web/escape_ext.so"
rescue LoadError
  module Web
    ESCAPE = "ruby"
    HTMLEntity = Hash.new
    HTMLEntity["Aacute"] = "\303\201"
    HTMLEntity["aacute"] = "\303\241"
    HTMLEntity["Acirc"] = "\303\202"
    HTMLEntity["acirc"] = "\303\242"
    HTMLEntity["acute"] = "\302\264"
    HTMLEntity["AElig"] = "\303\206"
    HTMLEntity["aelig"] = "\303\246"
    HTMLEntity["Agrave"] = "\303\200"
    HTMLEntity["agrave"] = "\303\240"
    HTMLEntity["alefsym"] = "\342\204\265"
    HTMLEntity["Alpha"] = "\316\221"
    HTMLEntity["alpha"] = "\316\261"
    HTMLEntity["and"] = "\342\210\247"
    HTMLEntity["ang"] = "\342\210\240"
    HTMLEntity["apos"] = "'"
    HTMLEntity["Aring"] = "\303\205"
    HTMLEntity["aring"] = "\303\245"
    HTMLEntity["asymp"] = "\342\211\210"
    HTMLEntity["Atilde"] = "\303\203"
    HTMLEntity["atilde"] = "\303\243"
    HTMLEntity["Auml"] = "\303\204"
    HTMLEntity["auml"] = "\303\244"
    HTMLEntity["bdquo"] = "\342\200\236"
    HTMLEntity["Beta"] = "\316\222"
    HTMLEntity["beta"] = "\316\262"
    HTMLEntity["brvbar"] = "\302\246"
    HTMLEntity["bull"] = "\342\200\242"
    HTMLEntity["cap"] = "\342\210\251"
    HTMLEntity["Ccedil"] = "\303\207"
    HTMLEntity["ccedil"] = "\303\247"
    HTMLEntity["cedil"] = "\302\270"
    HTMLEntity["cent"] = "\302\242"
    HTMLEntity["Chi"] = "\316\247"
    HTMLEntity["chi"] = "\317\207"
    HTMLEntity["circ"] = "\313\206"
    HTMLEntity["clubs"] = "\342\231\243"
    HTMLEntity["cong"] = "\342\211\205"
    HTMLEntity["copy"] = "\302\251"
    HTMLEntity["crarr"] = "\342\206\265"
    HTMLEntity["cup"] = "\342\210\252"
    HTMLEntity["curren"] = "\302\244"
    HTMLEntity["dagger"] = "\342\200\240"
    HTMLEntity["Dagger"] = "\342\200\241"
    HTMLEntity["darr"] = "\342\206\223"
    HTMLEntity["dArr"] = "\342\207\223"
    HTMLEntity["deg"] = "\302\260"
    HTMLEntity["Delta"] = "\316\224"
    HTMLEntity["delta"] = "\316\264"
    HTMLEntity["diams"] = "\342\231\246"
    HTMLEntity["divide"] = "\303\267"
    HTMLEntity["Eacute"] = "\303\211"
    HTMLEntity["eacute"] = "\303\251"
    HTMLEntity["Ecirc"] = "\303\212"
    HTMLEntity["ecirc"] = "\303\252"
    HTMLEntity["Egrave"] = "\303\210"
    HTMLEntity["egrave"] = "\303\250"
    HTMLEntity["empty"] = "\342\210\205"
    HTMLEntity["emsp"] = "\342\200\203"
    HTMLEntity["ensp"] = "\342\200\202"
    HTMLEntity["Epsilon"] = "\316\225"
    HTMLEntity["epsilon"] = "\316\265"
    HTMLEntity["equiv"] = "\342\211\241"
    HTMLEntity["Eta"] = "\316\227"
    HTMLEntity["eta"] = "\316\267"
    HTMLEntity["ETH"] = "\303\220"
    HTMLEntity["eth"] = "\303\260"
    HTMLEntity["Euml"] = "\303\213"
    HTMLEntity["euml"] = "\303\253"
    HTMLEntity["euro"] = "\342\202\254"
    HTMLEntity["exist"] = "\342\210\203"
    HTMLEntity["fnof"] = "\306\222"
    HTMLEntity["forall"] = "\342\210\200"
    HTMLEntity["frac12"] = "\302\275"
    HTMLEntity["frac14"] = "\302\274"
    HTMLEntity["frac34"] = "\302\276"
    HTMLEntity["frasl"] = "\342\201\204"
    HTMLEntity["Gamma"] = "\316\223"
    HTMLEntity["gamma"] = "\316\263"
    HTMLEntity["ge"] = "\342\211\245"
    HTMLEntity["harr"] = "\342\206\224"
    HTMLEntity["hArr"] = "\342\207\224"
    HTMLEntity["hearts"] = "\342\231\245"
    HTMLEntity["hellip"] = "\342\200\246"
    HTMLEntity["Iacute"] = "\303\215"
    HTMLEntity["iacute"] = "\303\255"
    HTMLEntity["Icirc"] = "\303\216"
    HTMLEntity["icirc"] = "\303\256"
    HTMLEntity["iexcl"] = "\302\241"
    HTMLEntity["Igrave"] = "\303\214"
    HTMLEntity["igrave"] = "\303\254"
    HTMLEntity["image"] = "\342\204\221"
    HTMLEntity["infin"] = "\342\210\236"
    HTMLEntity["int"] = "\342\210\253"
    HTMLEntity["Iota"] = "\316\231"
    HTMLEntity["iota"] = "\316\271"
    HTMLEntity["iquest"] = "\302\277"
    HTMLEntity["isin"] = "\342\210\210"
    HTMLEntity["Iuml"] = "\303\217"
    HTMLEntity["iuml"] = "\303\257"
    HTMLEntity["Kappa"] = "\316\232"
    HTMLEntity["kappa"] = "\316\272"
    HTMLEntity["Lambda"] = "\316\233"
    HTMLEntity["lambda"] = "\316\273"
    HTMLEntity["lang"] = "\342\214\251"
    HTMLEntity["laquo"] = "\302\253"
    HTMLEntity["larr"] = "\342\206\220"
    HTMLEntity["lArr"] = "\342\207\220"
    HTMLEntity["lceil"] = "\342\214\210"
    HTMLEntity["ldquo"] = "\342\200\234"
    HTMLEntity["le"] = "\342\211\244"
    HTMLEntity["lfloor"] = "\342\214\212"
    HTMLEntity["lowast"] = "\342\210\227"
    HTMLEntity["loz"] = "\342\227\212"
    HTMLEntity["lrm"] = "\342\200\216"
    HTMLEntity["lsaquo"] = "\342\200\271"
    HTMLEntity["lsquo"] = "\342\200\230"
    HTMLEntity["macr"] = "\302\257"
    HTMLEntity["mdash"] = "\342\200\224"
    HTMLEntity["micro"] = "\302\265"
    HTMLEntity["middot"] = "\302\267"
    HTMLEntity["minus"] = "\342\210\222"
    HTMLEntity["Mu"] = "\316\234"
    HTMLEntity["mu"] = "\316\274"
    HTMLEntity["nabla"] = "\342\210\207"
    HTMLEntity["nbsp"] = "\302\240"
    HTMLEntity["ndash"] = "\342\200\223"
    HTMLEntity["ne"] = "\342\211\240"
    HTMLEntity["ni"] = "\342\210\213"
    HTMLEntity["not"] = "\302\254"
    HTMLEntity["notin"] = "\342\210\211"
    HTMLEntity["nsub"] = "\342\212\204"
    HTMLEntity["Ntilde"] = "\303\221"
    HTMLEntity["ntilde"] = "\303\261"
    HTMLEntity["Nu"] = "\316\235"
    HTMLEntity["nu"] = "\316\275"
    HTMLEntity["Oacute"] = "\303\223"
    HTMLEntity["oacute"] = "\303\263"
    HTMLEntity["Ocirc"] = "\303\224"
    HTMLEntity["ocirc"] = "\303\264"
    HTMLEntity["OElig"] = "\305\222"
    HTMLEntity["oelig"] = "\305\223"
    HTMLEntity["Ograve"] = "\303\222"
    HTMLEntity["ograve"] = "\303\262"
    HTMLEntity["oline"] = "\342\200\276"
    HTMLEntity["Omega"] = "\316\251"
    HTMLEntity["omega"] = "\317\211"
    HTMLEntity["Omicron"] = "\316\237"
    HTMLEntity["omicron"] = "\316\277"
    HTMLEntity["oplus"] = "\342\212\225"
    HTMLEntity["or"] = "\342\210\250"
    HTMLEntity["ordf"] = "\302\252"
    HTMLEntity["ordm"] = "\302\272"
    HTMLEntity["Oslash"] = "\303\230"
    HTMLEntity["oslash"] = "\303\270"
    HTMLEntity["Otilde"] = "\303\225"
    HTMLEntity["otilde"] = "\303\265"
    HTMLEntity["otimes"] = "\342\212\227"
    HTMLEntity["Ouml"] = "\303\226"
    HTMLEntity["ouml"] = "\303\266"
    HTMLEntity["para"] = "\302\266"
    HTMLEntity["part"] = "\342\210\202"
    HTMLEntity["permil"] = "\342\200\260"
    HTMLEntity["perp"] = "\342\212\245"
    HTMLEntity["Phi"] = "\316\246"
    HTMLEntity["phi"] = "\317\206"
    HTMLEntity["Pi"] = "\316\240"
    HTMLEntity["pi"] = "\317\200"
    HTMLEntity["piv"] = "\317\226"
    HTMLEntity["plusmn"] = "\302\261"
    HTMLEntity["pound"] = "\302\243"
    HTMLEntity["prime"] = "\342\200\262"
    HTMLEntity["Prime"] = "\342\200\263"
    HTMLEntity["prod"] = "\342\210\217"
    HTMLEntity["prop"] = "\342\210\235"
    HTMLEntity["Psi"] = "\316\250"
    HTMLEntity["psi"] = "\317\210"
    HTMLEntity["radic"] = "\342\210\232"
    HTMLEntity["rang"] = "\342\214\252"
    HTMLEntity["raquo"] = "\302\273"
    HTMLEntity["rarr"] = "\342\206\222"
    HTMLEntity["rArr"] = "\342\207\222"
    HTMLEntity["rceil"] = "\342\214\211"
    HTMLEntity["rdquo"] = "\342\200\235"
    HTMLEntity["real"] = "\342\204\234"
    HTMLEntity["reg"] = "\302\256"
    HTMLEntity["rfloor"] = "\342\214\213"
    HTMLEntity["Rho"] = "\316\241"
    HTMLEntity["rho"] = "\317\201"
    HTMLEntity["rlm"] = "\342\200\217"
    HTMLEntity["rsaquo"] = "\342\200\272"
    HTMLEntity["rsquo"] = "\342\200\231"
    HTMLEntity["sbquo"] = "\342\200\232"
    HTMLEntity["Scaron"] = "\305\240"
    HTMLEntity["scaron"] = "\305\241"
    HTMLEntity["sdot"] = "\342\213\205"
    HTMLEntity["sect"] = "\302\247"
    HTMLEntity["shy"] = "\302\255"
    HTMLEntity["Sigma"] = "\316\243"
    HTMLEntity["sigma"] = "\317\203"
    HTMLEntity["sigmaf"] = "\317\202"
    HTMLEntity["sim"] = "\342\210\274"
    HTMLEntity["spades"] = "\342\231\240"
    HTMLEntity["sub"] = "\342\212\202"
    HTMLEntity["sube"] = "\342\212\206"
    HTMLEntity["sum"] = "\342\210\221"
    HTMLEntity["sup"] = "\342\212\203"
    HTMLEntity["sup1"] = "\302\271"
    HTMLEntity["sup2"] = "\302\262"
    HTMLEntity["sup3"] = "\302\263"
    HTMLEntity["supe"] = "\342\212\207"
    HTMLEntity["szlig"] = "\303\237"
    HTMLEntity["Tau"] = "\316\244"
    HTMLEntity["tau"] = "\317\204"
    HTMLEntity["there4"] = "\342\210\264"
    HTMLEntity["Theta"] = "\316\230"
    HTMLEntity["theta"] = "\316\270"
    HTMLEntity["thetasym"] = "\317\221"
    HTMLEntity["thinsp"] = "\342\200\211"
    HTMLEntity["THORN"] = "\303\236"
    HTMLEntity["thorn"] = "\303\276"
    HTMLEntity["tilde"] = "\313\234"
    HTMLEntity["times"] = "\303\227"
    HTMLEntity["trade"] = "\342\204\242"
    HTMLEntity["Uacute"] = "\303\232"
    HTMLEntity["uacute"] = "\303\272"
    HTMLEntity["uarr"] = "\342\206\221"
    HTMLEntity["uArr"] = "\342\207\221"
    HTMLEntity["Ucirc"] = "\303\233"
    HTMLEntity["ucirc"] = "\303\273"
    HTMLEntity["Ugrave"] = "\303\231"
    HTMLEntity["ugrave"] = "\303\271"
    HTMLEntity["uml"] = "\302\250"
    HTMLEntity["upsih"] = "\317\222"
    HTMLEntity["Upsilon"] = "\316\245"
    HTMLEntity["upsilon"] = "\317\205"
    HTMLEntity["Uuml"] = "\303\234"
    HTMLEntity["uuml"] = "\303\274"
    HTMLEntity["weierp"] = "\342\204\230"
    HTMLEntity["Xi"] = "\316\236"
    HTMLEntity["xi"] = "\316\276"
    HTMLEntity["Yacute"] = "\303\235"
    HTMLEntity["yacute"] = "\303\275"
    HTMLEntity["yen"] = "\302\245"
    HTMLEntity["yuml"] = "\303\277"
    HTMLEntity["Yuml"] = "\305\270"
    HTMLEntity["Zeta"] = "\316\226"
    HTMLEntity["zeta"] = "\316\266"
    HTMLEntity["zwj"] = "\342\200\215"
    HTMLEntity["zwnj"] = "\342\200\214"

    def self::escape(str)
      str = str.gsub(/[^ 0-9A-Za-z\-_.]+/n) {|x|
        ('%%%02X' * x.size) % x.unpack('C*')
      }
      str.tr!(' ','+')
      str
    end

    def self::unescape(str)
      str = str.tr('+',' ')
      str.gsub!(/(?:%[0-9a-zA-Z][0-9a-zA-Z])+/n) {|x|
        x.delete!('%')
        [x].pack('H*')
      }
      str
    end

    def self::escapeHTML(str)
      begin
        str = str.gsub(/&/,'&amp;')
      rescue
        str = ''
      end
      str.gsub!(/"/,'&quot;')
      str.gsub!(/</,'&lt;')
      str.gsub!(/>/,'&gt;')
      str
    end

    def self::unescapeHTML(str,htmlentity = Web::HTMLEntity)
      str.gsub(/&(.+?);/) {
        m = $1.dup
        case m
        when 'lt'   then '<'
        when 'gt'   then '>'
        when 'amp'  then '&'
        when 'quot' then '"'
        when /\A#([0-9]+)\z/
          cp = $1.to_i
          if cp < 0x10ffff
            [cp].pack('U')
          else
            raise RangeError
          end
        when /\A#x([0-9a-f]+)\z/i
          cp = $1.hex
          if cp < 0x10ffff
            [cp].pack('U')
          else
            raise RangeError
          end
        else
          raise RangeError
        end
      }
    end
  end # Web
end
