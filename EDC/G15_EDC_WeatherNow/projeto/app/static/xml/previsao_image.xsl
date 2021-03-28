<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">


        <xsl:for-each select="cidade/previsao[1]">

            <!-- ec	Encoberto com Chuvas Isoladas -->
            <xsl:if test="tempo = 'ec' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Encoberto com chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ci	Chuvas Isoladas -->
            <xsl:if test="tempo= 'ci' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva isolada</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- c	Chuva -->
            <xsl:if test="tempo= 'c' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- in	Instável -->
            <xsl:if test="tempo= 'in' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Instável</p>
               </div>
                <img src="https://www.zougla.gr/assets/images/2423786.jpg" />
            </xsl:if>

            <!-- pp	Poss. de Pancadas de Chuva -->
            <xsl:if test="tempo= 'pp' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Pancadas de chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- cm	Chuva pela Manhã -->
            <xsl:if test="tempo= 'cm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva pela manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- cn	Chuva a Noite -->
            <xsl:if test="tempo= 'cn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva à noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- pt	Pancadas de Chuva a Tarde -->
            <xsl:if test="tempo= 'pt' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva à tarde</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>


            <!-- pm	Pancadas de Chuva pela Manhã -->
            <xsl:if test="tempo= 'pm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Pancadas de chuva, manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- np	Nublado e Pancadas de Chuva -->
            <xsl:if test="tempo= 'np' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com panc. chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- pn	Parcialmente Nublado -->
            <xsl:if test="tempo= 'pn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-3 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Parcialmente nublado</p>
               </div>
                <img src="https://www.agraer.ms.gov.br/wp-content/uploads/2020/01/Tempo-Sol-entre-nuvens-Foto-Edemir-Rodrigues-1.jpg" />
            </xsl:if>

            <!-- cv	Chuvisco -->
            <xsl:if test="tempo = 'cv' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuvisco</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ch	Chuvoso -->
            <xsl:if test="tempo= 'ch' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuvoso</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- t	Tempestade -->
            <xsl:if test="tempo= 't' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Tempestade</p>
               </div>
                <img src="https://cdn.vezdavoz.com.br/wp-content/uploads/2018/04/tempestade-de-raios.jpg" />
            </xsl:if>

            <!-- ps	Predomínio de Sol -->
            <xsl:if test="tempo= 'ps' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Sol</p>
               </div>
                <img src="https://www.eaglevalleynews.com/wp-content/uploads/2019/04/16619380_web1_SunnyFarmland1WEB.jpg" />
            </xsl:if>

            <!-- e	Encoberto -->
            <xsl:if test="tempo= 'e' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Encoberto</p>
               </div>
                <img src="https://acreagora.com/wp-content/uploads/2019/03/temponublado.jpg" />
            </xsl:if>

            <!-- n	Nublado -->
            <xsl:if test="tempo= 'n' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado</p>
               </div>
                <img src="https://acreagora.com/wp-content/uploads/2019/03/temponublado.jpg" />
            </xsl:if>

            <!-- cl	Céu Claro -->
            <xsl:if test="tempo= 'cl' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Céu claro</p>
               </div>
                <img src="https://www.eaglevalleynews.com/wp-content/uploads/2019/04/16619380_web1_SunnyFarmland1WEB.jpg" />
            </xsl:if>

            <!-- nv	Nevoeiro -->
            <xsl:if test="tempo= 'nv' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nevoeiro</p>
               </div>
                <img src="https://mynorthwest.com/wp-content/uploads/2019/11/seattle-rain-620-flickr.jpg" />
            </xsl:if>

           <!-- g	Geada -->
            <xsl:if test="tempo = 'g' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Geada</p>
               </div>
                <img src="https://www.wallpaperup.com/uploads/wallpapers/2015/02/25/629052/c5f796f72e2ecd32442e15b1b2a65a81.jpg" />
            </xsl:if>

            <!-- ne	Neve -->
            <xsl:if test="tempo= 'ne' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Neve</p>
               </div>
                <img src="https://mynorthwest.com/wp-content/uploads/2019/11/seattle-rain-620-flickr.jpg" />
            </xsl:if>

            <!-- nd	Não Definido-->
            <xsl:if test="tempo= 'nd' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Não definida</p>
               </div>
                <img src="https://mynorthwest.com/wp-content/uploads/2019/11/seattle-rain-620-flickr.jpg" />
            </xsl:if>

            <!-- pnt	Pancadas de Chuva a Noite -->
            <xsl:if test="tempo= 'pnt' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuvisco à noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- psc	Possibilidade de Chuva -->
            <xsl:if test="tempo= 'psc' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Possibilidade chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- pcm	Possibilidade de Chuva pela Manhã -->
            <xsl:if test="tempo= 'pcm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Possibilidade chuva, manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- pct	Possibilidade de Chuva a Tarde -->
            <xsl:if test="tempo= 'pct' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Possibilidade chuva, tarde</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- pcn	Possibilidade de Chuva a Noite -->
            <xsl:if test="tempo= 'pcn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Possibilidade chuva, noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- npt	Nublado com Pancadas a Tarde -->

            <xsl:if test="tempo= 'npt' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva, tarde</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- npn	Nublado com Pancadas a Noite -->
            <xsl:if test="tempo= 'npn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
            <xsl:if test="tempo= 'ncn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva, noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
            <xsl:if test="tempo= 'nct' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva tarde</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
            <xsl:if test="tempo= 'ncm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva, manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- npm	Nublado com Pancadas pela Manhã -->
            <xsl:if test="tempo= 'npm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva, manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- npp	Nublado com Possibilidade de Chuva -->
            <xsl:if test="tempo= 'pcn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- vn	Variação de Nebulosidade -->
            <xsl:if test="tempo= 'vn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Variação de nebulosidade</p>
               </div>
               <img src="https://mynorthwest.com/wp-content/uploads/2019/11/seattle-rain-620-flickr.jpg" />

            </xsl:if>

             <!-- ct	Nublado com Pancadas pela Manhã -->
            <xsl:if test="tempo= 'ct' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Nublado com chuva, manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
            <xsl:if test="tempo= 'ppn' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva à noite</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
            <xsl:if test="tempo= 'ppt' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva pela tarde</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
            <xsl:if test="tempo= 'ppm' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva pela manhã</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

            <xsl:if test="tempo= 'pc' ">
               <div class="badge badge-danger deep-orange darken-4 weather-part-second-image-label pl-3 pr-3 pt-2 rounded-0">
                    <p class="text-white">Cidade: <b><xsl:value-of select="/cidade/nome"/></b></p>
                    <p class="text-white">Condição: Chuva dia todo</p>
               </div>
                <img src="https://static-wp-canalr-prd.canalrural.com.br/2019/03/car-drops-of-water-glass-155328129.jpg" />
            </xsl:if>

        </xsl:for-each>



    </xsl:template>
</xsl:stylesheet>