<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

            <div class="col-lg-12 col-12 text-center">
                <div class="weather-part-second-icon bg-white">
                    <div class="row">
                        <div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[1]/dia"/> </p>

                            <xsl:if test="cidade/previsao[1]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[1]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[1]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[1]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[1]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[1]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[1]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[1]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[1]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[1]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[1]/minima"/>º </p>
                    	</div>
                          
                            
                        <div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[2]/dia"/> </p>

                            <xsl:if test="cidade/previsao[2]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[2]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[2]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[2]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[2]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[2]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[2]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[2]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[2]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[2]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[2]/minima"/>º </p>
                        </div>
                           
                        <div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[3]/dia"/> </p>

                            <xsl:if test="cidade/previsao[3]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[3]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[3]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[3]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[3]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[3]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[3]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[3]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[3]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[3]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[3]/minima"/>º </p>
                        </div>

                 
						<div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[4]/dia"/> </p>

                            <xsl:if test="cidade/previsao[4]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[4]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[4]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[4]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[4]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[4]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[4]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[4]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[4]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[4]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[4]/minima"/>º </p>
                        </div>
                            
						<div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[5]/dia"/> </p>

                            <xsl:if test="cidade/previsao[5]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[5]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[5]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[5]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[5]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[5]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[5]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[5]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[5]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[5]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[5]/minima"/>º </p>
                        </div>
                         
						<div class="col-lg-2 col-6 p-2">
                            <p> <xsl:value-of select="cidade/previsao[6]/dia"/> </p>

                            <xsl:if test="cidade/previsao[6]/tempo = 'c' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[6]/tempo = 'ec' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ci	Chuvas Isoladas -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ci' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- in	Instável -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'in' ">
                                <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pp	Poss. de Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pp' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cm	Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'cm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cn	Chuva a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'cn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pt	Pancadas de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pm	Pancadas de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- np	Nublado e Pancadas de Chuva -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'np' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pn	Parcialmente Nublado -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pn' ">
                                    <p class="fas fa-cloud-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cv	Chuvisco -->
                            <xsl:if test="cidade/previsao[6]/tempo = 'cv' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ch	Chuvoso -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ch' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- t	Tempestade -->
                            <xsl:if test="cidade/previsao[6]/tempo= 't' ">
                                    <p class="fas fa-bolt" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ps	Predomínio de Sol -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ps' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- e	Encoberto -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'e' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- n	Nublado -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'n' ">
                                    <p class="fas fa-cloud-meatball" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- cl	Céu Claro -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'cl' ">
                                    <p class="fas fa-sun" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nv	Nevoeiro -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'nv' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                           <!-- g	Geada -->
                            <xsl:if test="cidade/previsao[6]/tempo = 'g' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ne	Neve -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ne' ">
                                    <p class="far fa-snowflake" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nd	Não Definido-->
                            <xsl:if test="cidade/previsao[6]/tempo= 'nd' ">
                                    <p class="" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pnt	Pancadas de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pnt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- psc	Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'psc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcm	Possibilidade de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pcm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pct	Possibilidade de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- pcn	Possibilidade de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npt	Nublado com Pancadas a Tarde -->

                            <xsl:if test="cidade/previsao[6]/tempo= 'npt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npn	Nublado com Pancadas a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'npn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncn	Nublado com Poss. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ncn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- nct	Nublado com Poss. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'nct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ncm	Nubl. c/ Poss. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ncm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npm	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'npm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- npp	Nublado com Possibilidade de Chuva -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'pcn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- vn	Variação de Nebulosidade -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'vn' ">
                                    <p class="fas fa-smog" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                             <!-- ct	Nublado com Pancadas pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ct' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppn	Poss. de Panc. de Chuva a Noite -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ppn' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppt	Poss. de Panc. de Chuva a Tarde -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ppt' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <!-- ppm	Poss. de Panc. de Chuva pela Manhã -->
                            <xsl:if test="cidade/previsao[6]/tempo= 'ppm' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <xsl:if test="cidade/previsao[6]/tempo= 'pc' ">
                                    <p class="fas fa-cloud-rain" style='font-size:36px; color:blue'></p>
                            </xsl:if>

                            <p class="text-danger"> <xsl:value-of select="cidade/previsao[6]/maxima"/>º </p>
                            <p class="text-info"> <xsl:value-of select="cidade/previsao[6]/minima"/>º </p>
                        </div>
                    </div>
                </div>
            </div>

    </xsl:template>
</xsl:stylesheet>