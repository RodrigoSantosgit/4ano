<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">


        <xsl:for-each select="cidade/previsao[1]">
            
            <xsl:if test="agitacao = 'Fraco'">
                <img
    				src="https://mdbootstrap.com/img/new/standard/nature/111.jpg"
    				class="card-img-top"
    				alt="..."
    			/>
            </xsl:if>

            <xsl:if test="agitacao = 'Forte'">
                <img src="https://www.publicdomainpictures.net/pictures/200000/velka/mar-revuelto.jpg" 
                    class="card-img-top" 
                    alt="..." />
            </xsl:if>

            <xsl:if test="agitacao = 'Moderado'">
                <img src="https://images.freeimages.com/images/large-previews/f88/seaside-sunset-1334240.jpg" 
                    class="card-img-top" 
                    alt="..." />
            </xsl:if>

        </xsl:for-each>



    </xsl:template>
</xsl:stylesheet>