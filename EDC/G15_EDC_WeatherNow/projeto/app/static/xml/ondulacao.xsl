<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

            <div class="d-flex justify-content-lg-between">
                <xsl:for-each select="cidade/previsao[1]">
                    <p></p>
                    <h5>Altura: <xsl:value-of select="altura"/> m</h5>
                    <h5>Agitação: <xsl:value-of select="agitacao"/></h5>
                    <h5>Direção Ondas: <xsl:value-of select="direcao"/></h5>
                    <h5>Vento: <xsl:value-of select="vento"/> km/h</h5>
                    <h5>Direção Vento: <xsl:value-of select="vento_dir"/></h5>
                    <p></p>
                </xsl:for-each>
            </div>

    </xsl:template>
</xsl:stylesheet>