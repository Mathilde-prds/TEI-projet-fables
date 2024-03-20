<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <!-- 1. INSTRUCTION D'OUTPUT : HTML -->
    <xsl:output method="html"/>
    
    <!-- 2. VARIABLES -->
    <xsl:variable name="home">
        <xsl:value-of select="concat('PRADES_home', '.html')"/>
        <!-- variable pour le contenu de la page d'accueil -->
    </xsl:variable>
    <xsl:variable name="fable9">
        <xsl:value-of select="concat('PRADES_fable9', '.html')"/>
        <!-- variable pour le contenu de la fable 9 -->
    </xsl:variable>
    <xsl:variable name="fable10">
        <xsl:value-of select="concat('PRADES_fable10', '.html')"/>
        <!-- variable pour le contenu de la fable 10 -->
    </xsl:variable>
    <xsl:variable name="fable11">
        <xsl:value-of select="concat('PRADES_fable11', '.html')"/>
        <!-- variable pour le contenu de la fable 11 -->
    </xsl:variable>
    <xsl:variable name="index">
        <xsl:value-of select="concat('PRADES_index', '.html')"/>
        <!-- variable pour le contenu de l'index -->
    </xsl:variable>
    <xsl:variable name="header">
        <!-- variable pour le contenu du header -->
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <title><xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title"/></title>
            <xsl:element name="meta">
                <xsl:attribute name="name">description</xsl:attribute>
                <xsl:attribute name="content">
                    <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title"/>
                </xsl:attribute>
            </xsl:element>
            <link type='text/css' rel='stylesheet' href='PRADES-devoir_final.css'/>
        </head>
    </xsl:variable>
    <xsl:variable name="footer">
        <!-- variable pour le contenu du footer des fables -->
        <footer>
            <xsl:value-of select="//teiHeader/fileDesc/editionStmt/edition"/>
        </footer>
    </xsl:variable>

    
    <!-- 3. REGLES SUR LA RACINE : création de 5 documents HTML + appel du texte original et du texte modernisé -->
    <xsl:template match="/">
        <xsl:call-template name="home"/>
        <xsl:call-template name="fable9"/>
        <xsl:call-template name="fable10"/>
        <xsl:call-template name="fable11"/>
        <xsl:call-template name="index"/>
        <xsl:call-template name="orig"/>
        <xsl:call-template name="reg"/>
    </xsl:template>
    
    <!-- 4. TEMPLATE DE LA PAGE D'ACCUEIL -->
    <xsl:template name="home">
        <xsl:result-document href="{$home}" method="html" indent='yes'>
            
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body class="container">
                    <div>
                        <img src="img/plat_sup.jpg" alt="plat superieur du livre encodé"/>
                        <h1 class="h1">Édition en ligne des <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/title"/></h1>
                        <p><xsl:value-of select="concat(TEI/teiHeader/fileDesc/titleStmt/author/forename, ' ', TEI/teiHeader/fileDesc/titleStmt/author/surname)"/></p>
                        <p><xsl:value-of select="TEI/teiHeader/fileDesc/editionStmt/edition"/></p>
                        <p>Publiée <xsl:value-of select="concat(replace(TEI/teiHeader/fileDesc/publicationStmt/pubPlace/address/addrLine[1], 'A', 'à'), ' ', TEI/teiHeader/fileDesc/publicationStmt/pubPlace/address/addrLine[2], ' ', TEI/teiHeader/fileDesc/publicationStmt/pubPlace/address/addrLine[3])"/></p>
                        <p><xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/respStmt[@xml:id='graveur']/resp"/> : <xsl:value-of select="concat(TEI/teiHeader/fileDesc/titleStmt/respStmt[@xml:id='graveur']/persName/forename, ' ', TEI/teiHeader/fileDesc/titleStmt/respStmt[@xml:id='graveur']/persName/surname)"/></p>
                        <p>
                            <xsl:element name="a">
                                <xsl:attribute name="href">
                                    <xsl:value-of select="TEI/teiHeader/fileDesc/sourceDesc/biblStruct/citedRange/@target"/>
                                </xsl:attribute>
                                <xsl:attribute name="class">link</xsl:attribute>
                                Lien vers la numérisation du livre
                            </xsl:element>
                        </p>
                        <p>
                            <xsl:value-of select="TEI/teiHeader/encodingDesc/projectDesc/p"/>
                        </p>
                    </div>
                    <!-- Liens vers les autres pages -->
                    <div class="nav">
                        <p><b>Navigation : </b></p>
                        <a href="{$fable9}" class="link">Fable 9</a><span style="margin-right: 10px;"> ⁂ </span>
                        <a href="{$fable10}" class="link">Fable 10</a><span style="margin-right: 10px;"> ⁂ </span>
                        <a href="{$fable11}" class="link">Fable 11</a><span style="margin-right: 10px;"> ⁂ </span>
                        <a href="{$index}" class="link">Index</a>
                    </div>
                    <footer>
                        <xsl:value-of select="TEI/teiHeader/fileDesc/titleStmt/respStmt[@xml:id='encodeur']/resp"/> : <xsl:value-of select="concat(//teiHeader/fileDesc/titleStmt/respStmt[@xml:id='encodeur']/persName/forename, ' ', //teiHeader/fileDesc/titleStmt/respStmt[@xml:id='encodeur']/persName/surname)"/>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <!-- 5. TEMPLATE DE LA FABLE 9 -->
    <xsl:template name="fable9">
        <xsl:result-document href="{$fable9}" method="html" indent="yes">
            
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body class="container">
                    <div>
                        <h2 class="h1"><xsl:value-of select="//text/body/div[@corresp='#fable9']/head[@rend='level2']"/></h2>
                        <!-- Transformation de la balise <figure> en XML-TEI à la balise <img> utilisée en HTML pour afficher les images -->
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="//text/body/div[@corresp='#fable9']/figure/graphic/@url"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="//text/body/div[@corresp='#fable9']/figure/figDesc"/>
                            </xsl:attribute>
                        </xsl:element>
                        <h3 class="h2"><xsl:value-of select="//text/body/div[@corresp='#fable9']/head[@rend='level3']"/></h3>
                        <!-- Ajout des numéros de page de l'original et des liens vers les pages encodées -->
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/pb[1]/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/pb[1]/@n"/>
                        </xsl:element> &amp; 
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/div[@corresp='#fable9']/div[@type='corps']/pb/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/div[@corresp='#fable9']/div[@type='corps']/pb/@n"/>
                        </xsl:element>
                    </div>
                    <div>
                        <div>
                            <!-- Div qui récupère le texte original de la fable 9 grâce au @mode "orig" -->
                            <h4 class="h4">Texte original</h4>
                            <div>
                                <h4>Exposition : </h4>
                                 <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='exposition']/lg">
                                     <div>
                                         <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                           <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                     </div>
                                 </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div>
                            <h4 class="h4">Texte modernisé</h4>
                            <div>
                                <!-- Div qui récupère le texte modernisé de la fable 9 grâce au @mode "reg" -->
                                <h4>Exposition : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='exposition']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable9']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div class="nav">
                        <a href="{$home}" class="link">Page d'accueil</a>
                        <xsl:text> ⁂ </xsl:text>
                        <a href="./{$fable10}" class="link">Suivante</a>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- 6. DOCUMENT DE LA FABLE 10 -->
    <xsl:template name="fable10">
        <xsl:result-document href="{$fable10}" method="html" indent="yes">
            
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body class="container"> <!-- Les attributs @class sont relié au fichier css afin de mettre en forme les fchiers sortant -->
                    <div>
                        <h2 class="h1"><xsl:value-of select="//text/body/div[@corresp='#fable10']/head[@rend='level2']"/></h2>
                        <!-- Transformation de la balise <figure> en XML-TEI à la balise <img> utilisée en HTML pour afficher les images -->
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="//text/body/div[@corresp='#fable10']/figure/graphic/@url"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="//text/body/div[@corresp='#fable10']/figure/figDesc"/>
                            </xsl:attribute>
                        </xsl:element>
                        <h3 class="h2"><xsl:value-of select="//text/body/div[@corresp='#fable10']/head[@rend='level3']"/></h3>
                        <!-- Ajout des numéros de page de l'original et des liens vers les pages encodées -->
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/pb[2]/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/pb[2]/@n"/>
                        </xsl:element> &amp; 
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/div[@corresp='#fable10']/div[@type='corps']/lg/pb/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/div[@corresp='#fable10']/div[@type='corps']/lg/pb/@n"/>
                        </xsl:element>
                        <div>
                            <!-- Div qui récupère le texte original de la fable 10 grâce au @mode "orig" -->
                            <h4 class="h4">Texte original</h4>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Exposition : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='exposition']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div>
                            <!-- Div qui récupère le texte modernisé de la fable 10 grâce au @mode "reg" -->
                            <h4 class="h4">Texte modernisé</h4>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Exposition : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='exposition']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable10']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div class="nav">
                        <a href="{$fable9}" class="link">Précédente</a>
                        <xsl:text> ⁂ </xsl:text>
                        <a href="{$home}" class="link">Page d'accueil</a>
                        <xsl:text> ⁂ </xsl:text>
                        <a href="./{$fable11}" class="link">Suivante</a>
                    </div>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <!-- 7. DOCUMENT DE LA FABLE 11 -->
    <xsl:template name="fable11">
        <xsl:result-document href="{$fable11}" method="html" indent="yes">
            
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body class="container">
                    <div>
                        <h2 class="h1"><xsl:value-of select="//text/body/div[@corresp='#fable11']/head[@rend='level2']"/></h2>
                        <!-- Transformation de la balise <figure> en XML-TEI à la balise <img> utilisée en HTML pour afficher les images -->
                        <xsl:element name="img">
                            <xsl:attribute name="src">
                                <xsl:value-of select="//text/body/div[@corresp='#fable11']/figure/graphic/@url"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="//text/body/div[@corresp='#fable11']/figure/figDesc"/>
                            </xsl:attribute>
                        </xsl:element>
                        <h3 class="h2"><xsl:value-of select="//text/body/div[@corresp='#fable11']/head[@rend='level3']"/></h3>
                        <!-- Ajout des numéros de page de l'original et des liens vers les pages encodées -->
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/pb[3]/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/pb[3]/@n"/>
                        </xsl:element> &amp; 
                        <xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="//text/body/div[@corresp='#fable11']/div[@type='corps']/lg/pb/@facs"/>
                            </xsl:attribute>
                            <xsl:attribute name="class">link</xsl:attribute>
                            <xsl:text>p.</xsl:text><xsl:value-of select="//text/body/div[@corresp='#fable11']/div[@type='corps']/lg/pb/@n"/>
                        </xsl:element>
                        <div>
                            <!-- Div qui récupère le texte original de la fable 11 grâce au @mode "orig" -->
                            <h4 class="h4">Texte original</h4>
                            <div>
                                <h4>Dédicace : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='dedication']/p">
                                    <p>
                                        <xsl:apply-templates select="." mode="orig"/>
                                        <a href="#reference" class="link">*</a>
                                    </p>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Exposition : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='exposition']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="orig"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                        <div>
                            <!-- Div qui récupère le texte modernisé de la fable 11 grâce au @mode "reg" -->
                            <h4 class="h4">Texte modernisé</h4>
                            <div>
                                <h4>Dédicace : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='dedication']/p">
                                    <p>
                                        <xsl:apply-templates select="." mode="reg"/>
                                        <a href="#reference" class="link">*</a>
                                    </p>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Exposition : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='exposition']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Corps du texte : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='corps']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                            <div>
                                <h4>Morale : </h4>
                                <xsl:for-each select="//text/body/div[@corresp='#fable11']/div[@type='morale']/lg">
                                    <div>
                                        <i>Strophe n°<xsl:value-of select="./@n"/> (schéma de rimes : <xsl:value-of select="./@rhyme"/>)</i>
                                        <xsl:for-each select="./l">
                                            <p><xsl:apply-templates select="." mode="reg"/></p>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div class="nav">
                        <a href="{$fable10}" class="link">Précédente</a>
                        <xsl:text> ⁂ </xsl:text>
                        <a href="{$home}" class="link">Page d'accueil</a>
                    </div>
                    <footer>
                        <xsl:value-of select="//teiHeader/fileDesc/editionStmt/edition"/>
                        <!-- Note de bas de page de contexte sur la dédicace -->
                        <a id="reference">
                            <p><i>
                                *<xsl:value-of select="TEI/teiHeader/profileDesc/particDesc/listPerson[@type='real']/person/persName"/>
                                <xsl:text> (</xsl:text><xsl:value-of select="TEI/teiHeader/profileDesc/particDesc/listPerson[@type='real']/person/birth"/>
                                <xsl:text>-</xsl:text><xsl:value-of select="TEI/teiHeader/profileDesc/particDesc/listPerson[@type='real']/person/death"/>
                                <xsl:text>) : </xsl:text><xsl:value-of select="TEI/teiHeader/profileDesc/particDesc/listPerson[@type='real']/person/note"/>.
                            </i></p>
                        </a>
                    </footer>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <!-- 8. SELECTION DU TEXTE ORIGINAL -->
    <xsl:template match="//text/body/div/div/lg/l//choice" mode="orig" name="orig">
        <xsl:apply-templates select="./orig"/>
    </xsl:template>
    
    <!-- 8. SELECTION DU TEXTE MODERNISE -->
    <xsl:template match="//text/body/div/div/lg/l//choice" mode="reg" name="reg">
        <xsl:apply-templates select="./reg"/>
    </xsl:template>
    
    
    <!-- 10. DOCUMENT DE L'INDEX -->
    <xsl:template name="index">
       <xsl:result-document href="{$index}" method="html" indent="yes">
           
           <html lang="fr">
               <xsl:copy-of select="$header"/>
               <body class="container">
                    <div>
                    <h1 class="h1">Index</h1>
                    <!-- BOUCLE N°1 : créer une <div> pour chaque personnage -->
                         <xsl:for-each-group select="TEI/text/body/div/div/lg/l/persName" group-by="./@ref">
                            <div>
                                <xsl:choose>
                                    <xsl:when test="./@ref='#RC'">
                                        <h2 class="h2"><xsl:text>Le Rat des Champs</xsl:text></h2>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#RV'">
                                        <h2 class="h2"><xsl:text>Le Rat de Ville</xsl:text></h2>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#L'">
                                        <h2 class="h2"><xsl:text>Le Loup</xsl:text></h2>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#A'">
                                        <h2 class="h2"><xsl:text>L'Agneau</xsl:text></h2>
                                    </xsl:when>
                                    <xsl:when test="./@ref='#H'">
                                        <h2 class="h2"><xsl:text>L'Homme</xsl:text></h2>
                                    </xsl:when>
                                </xsl:choose>
                                <!-- BOUCLE N°2 : créer un seul <p> par entrée d'index sans prendre en compte la casse -->
                                <xsl:for-each-group select="current-group()" group-by="lower-case(.)">
                                    <p>
                                        <xsl:choose>
                                            <!-- xsl:choose qui sert à gérer le cas où il y aurait un ou plusieurs mots modernisés dans la balise <persName> -->
                                            <xsl:when test="./choice">
                                                <b><xsl:value-of select="./text()"/>
                                                <xsl:text> </xsl:text>
                                                    <xsl:value-of select="./choice/reg"/> :</b>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <b><xsl:value-of select="."/> :</b>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <!-- BOUCLE N°3 : ajouter le n° de la ou des strophes <lg> où apparaissent les entrées d'index -->
                                        <xsl:for-each-group select="current-group()" group-by="ancestor::lg">
                                            <xsl:text> strophe </xsl:text>
                                            <xsl:value-of select="ancestor::lg/@n"/>
                                            <xsl:if test="position()!= last()">, 
                                            </xsl:if><xsl:if test="position() = last()">.</xsl:if>
                                        </xsl:for-each-group>
                                    </p>
                                </xsl:for-each-group>
                            </div>
                         </xsl:for-each-group>
                    </div>
                   <div class="nav">
                       <a href="{$home}" class="link">Page d'accueil</a>
                   </div>
               </body>
           </html>
       </xsl:result-document>
   </xsl:template>
    
    
</xsl:stylesheet>