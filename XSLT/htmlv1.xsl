<?xml version="1.0" encoding="UTF-8"?>

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:template match="/">
        
        <html lang="la">
            <head>
                <title><xsl:value-of select="/*/@title"/></title>
                
                <script type="text/x-mathjax-config">
                    MathJax.Hub.Config({
                    showProcessingMessages: true,
                    extensions: ["tex2jax.js"],
                    tex2jax: {inlineMath: [['\\(','\\)']]},
                    jax: ["input/TeX","output/HTML-CSS"],
                    "HTML-CSS": {
                    mtextFontInherit: true,
                    preferredFont: "TeX"
                    },
                    TeX: {
                    extensions: [ 'cancel.js', 'enclose.js', 'AMSmath.js', 'AMSsymbols.js'],
                    Macros: {
                    str: ["\\enclose{horizontalstrike}{#1}",1],
                    udl: ["\\underline{#1}",1],
                    subst: ["\\enclose{horizontalstrike}{#1}#2",2],
                    superscript: ["^{\\text{#1}}",1],
                    rectangle: ["\\unicode{9645}",0],
                    language: ["\\text{#1}",4],
                    upper: ["^{\\Large{#1}}",1],
                    below: ["_{\\Large{#1}}",1],
                    gap: ["‹ ›",1],
                    unclear: ["[?]",1]
                    }
                    },
                    errorSettings: {
                    message: ["[Math Processing Error]"],
                    style: {color:"#CC0000", "font-style":"italic"}
                    }
                    });
                    
                    MathJax.Hub.Register.MessageHook("TeX Jax - parse error",function (message) {
                    // http://docs.mathjax.org/en/latest/api/hub.html
                    // do something with the error.  message[1] will contain the data about the error.
                    alert("Parse error: " + message[1]);
                    });
                    
                    MathJax.Hub.Register.MessageHook("Math Processing Error",function (message) {
                    //  do something with the error.  message[2] is the Error object that records the problem.
                    alert("Processing error: " + message[1]);
                    });
                    
                    
                    
                </script>
                
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.1/MathJax.js"></script>
                
                <style>
                 
                 a.facsimile {
                    width: 16px;
                    height: 16px;
                    display: inline-flex;
                    background: url('icons/file_icon.gif');
                    background-size: cover;
                 } 
                 
                </style>
            </head>
            
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
        
    </xsl:template>
    

    <xsl:template match="persons">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="author|recipient|mentioned">
        <xsl:value-of select="./local-name()"/>
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="person">
        <li>
            <xsl:value-of select="./gnd"/><br/>
            <xsl:value-of select="./name"/>    
        </li>
    </xsl:template>
    
    
    <xsl:template match="images"></xsl:template>

    <xsl:template match="text">
      <div>

            <div id="transcription">
                <xsl:apply-templates/>
            </div>

            <div id="references">
              <ol>
                <xsl:apply-templates select="//ref" mode="references"/>
              </ol>
            </div>
      </div>

    </xsl:template>

    <xsl:template match="ref">
        <a class="ref_marker">
            <xsl:attribute name="href">
                <xsl:text>#ref</xsl:text>
                <xsl:number level="any" count="ref" format="1"/>
            </xsl:attribute>
            <sup><xsl:number level="any" count="ref" format="1"/></sup>
        </a>
    </xsl:template>

    <xsl:template match="ref" mode="references">
        <li>
            <xsl:attribute name="id">
                <xsl:text>ref</xsl:text>
                <xsl:number level="any" count="ref" format="1"/>
            </xsl:attribute>

            <xsl:apply-templates/>

        </li>
    </xsl:template>

    <xsl:template match="i">
        <em><xsl:apply-templates/></em>
    </xsl:template>

    <xsl:template match="b">
        <strong><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="u">
        <span style="text-decoration: underline;"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="sub">
        <sub><xsl:apply-templates/></sub>
    </xsl:template>

    <xsl:template match="sup">
        <sup><xsl:apply-templates/></sup>
    </xsl:template>

    <xsl:template match="math">
        <span class="math">\(<xsl:apply-templates/>\)</span>
    </xsl:template>

    <xsl:template match="facsimile|figure">
        <a class="facsimile salsah-link">
            <xsl:attribute name="href"><xsl:value-of select="@src" /></xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="entity">
        <a class="salsah-link">
            <xsl:attribute name="href"><xsl:value-of select="@ref" /></xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="a">
        <a class="external_link">
            <xsl:attribute name="href"><xsl:value-of select="@href" /></xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <xsl:template match="br">
        <br/>
    </xsl:template>

    <xsl:template match="pb">
        <span class="pagebreak"></span>
    </xsl:template>

    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="hr">
        <hr/>
    </xsl:template>

    <!-- table -->
    <xsl:template match="table">
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <!-- row -->
    <xsl:template match="table/tr">
        <tr>
            <xsl:apply-templates/>
        </tr></xsl:template>

    <!-- cell: get all attributes: border and align -->
    <xsl:template match="table/tr/td">
        <td><xsl:apply-templates/></td>
    </xsl:template>
    
    <!-- get original version -->
    <xsl:template match="correction"><xsl:apply-templates/></xsl:template>
    
    <xsl:template match="correction/corr"></xsl:template>
    
    <xsl:template match="correction/orig"><xsl:apply-templates/></xsl:template>
    
    <!-- expan: get non-expanded reading -->
    <xsl:template match="expan"><xsl:apply-templates/></xsl:template>
    
    <!-- ignore ex -->
    <xsl:template match="expan/ex"></xsl:template>
    
    <!-- keep am -->
    <xsl:template match="expan/am"><xsl:apply-templates/></xsl:template>
    
    <!-- entities -->
    <xsl:template match="mm_entity">m̄</xsl:template>
    
    <xsl:template match="nn_entity">n̄</xsl:template>

    <xsl:template match="etc._entity">&amp;c</xsl:template>

    <xsl:template match="ndot_entity">.</xsl:template>
    
    <xsl:template match="oe_entity">œ</xsl:template>
    
    <xsl:template match="ae_entity">æ</xsl:template>
    
    <xsl:template match="AE_entity">Æ</xsl:template>
    
    <xsl:template match="aacut_entity">á</xsl:template>
    
    <xsl:template match="agrav_entity">à</xsl:template>
    
    <xsl:template match="ahat_entity">â</xsl:template>
    
    <xsl:template match="am_entity">[a-]</xsl:template>
    
    <xsl:template match="eacut_entity">é</xsl:template>
    
    <xsl:template match="egrav_entity">è</xsl:template>
    
    <xsl:template match="ehat_entity">ê</xsl:template>
    
    <xsl:template match="em_entity">[e-]</xsl:template>
    
    <xsl:template match="en_entity">[-e]</xsl:template>
    
    <xsl:template match="oacut_entity">ó</xsl:template>
    
    <xsl:template match="ograv_entity">ò</xsl:template>
    
    <xsl:template match="ohat_entity">ô</xsl:template>
    
    <xsl:template match="uacut_entity">ú</xsl:template>
    
    <xsl:template match="ugrav_entity">ù</xsl:template>
    
    <xsl:template match="uhat_entity">û</xsl:template>
    
    <xsl:template match="que_entity">[qz]</xsl:template>
    
    <xsl:template match="um_entity">[u-]</xsl:template>
    
    <xsl:template match="ydots_entity">ÿ</xsl:template>
    
    <xsl:template match="septemb_entity">7b</xsl:template>
    
    <xsl:template match="decemb_entity">10b</xsl:template>
    
    <xsl:template match="amajgrav_entity">À</xsl:template>
    
    <xsl:template match="an_entity">[-a]</xsl:template>
    
    <xsl:template match="egravmaj_entity">È</xsl:template>
    
    <xsl:template match="igrav_entity">ì</xsl:template>
    
    <xsl:template match="ihat_entity">î</xsl:template>
    
    <xsl:template match="qui_entity">[q-]</xsl:template>
    
    <xsl:template match="per_entity">[p-]</xsl:template>
    
    <xsl:template match="Septemb_entity">[7-b]</xsl:template>
    
    <xsl:template match="tur_entity">[tz]</xsl:template>
    
    <xsl:template match="us_entity">[s]</xsl:template>
    
    <xsl:template match="NB_entity">[NB]</xsl:template>
   
    <xsl:template match="on_entity">[on]</xsl:template>
    
    <xsl:template match="pp_entity">[pp]</xsl:template>
    
    <xsl:template match="klammerzu_entity">:|</xsl:template>
  
    <xsl:template match="klammerauf_entity">|:</xsl:template>
    
    <xsl:template match="ll_entity">[ll]</xsl:template>
    
    <xsl:template match="OE_entity">Œ</xsl:template>
    
    <xsl:template match="die_entity">[d.]</xsl:template>
    
    <xsl:template match="Octob_entity">[8-b]</xsl:template>
    
    <xsl:template match="nddot_entity">:</xsl:template>
    
    <xsl:template match="j_entity">j</xsl:template>
    
    <xsl:template match="par_entity">[par]</xsl:template>
    
    <xsl:template match="est_entity">[est]</xsl:template>
    
    <xsl:template match="esse_entity">[esse]</xsl:template>
    
    <xsl:template match="omn_entity">o&#297;</xsl:template>
    
    <xsl:template match="im_entity">[i-]</xsl:template>
    
</xsl:transform>
