from django.shortcuts import render
from lxml import etree
from lxml import builder
from datetime import date
import re
import os
import unicodedata
from EDC_WEATHER.settings import BASE_DIR
import urllib.request
import xml.etree.ElementTree as ET
from urllib.request import urlopen
from BaseXClient import BaseXClient

from django.contrib.auth import login, authenticate
from django.shortcuts import render, redirect
from app.forms import SignUpForm
from django.contrib.auth import get_user_model
from django.http import HttpResponseRedirect
from django.urls import reverse
import feedparser


# Create your views here.
def index(request):
    feed = feedparser.parse('http://servicos.cptec.inpe.br/RSS/cidade/241/previsao.xml')
    description=feed.entries[0].description.replace('Previsão para os próximos dias:','').split('/>')
    feed2 = feedparser.parse('http://servicos.cptec.inpe.br/RSS/cidade/244/previsao.xml')
    description2=feed2.entries[0].description.replace('Previsão para os próximos dias:','').split('/>')
    feed3 = feedparser.parse('http://servicos.cptec.inpe.br/RSS/cidade/224/previsao.xml')
    description3=feed3.entries[0].description.replace('Previsão para os próximos dias:','').split('/>')
    context={
        "title":feed.entries[0].title,
        "image":description[0],
        "weather":description[1],

        "title2":feed2.entries[0].title,
        "image2":description2[0],
        "weather2":description2[1],

        "title3":feed3.entries[0].title,
        "image3":description3[0],
        "weather3":description3[1],
    }
    return render(request, 'index.html', context)

def submitEmail(request):
    if 'mail' in request.POST and 'username' in request.POST:
        mail=request.POST['mail']
        username = request.POST['username']
        User  = get_user_model()
        if mail != "":
            
            session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
            if not session:
                return render(request, 'erro.html', {"erro":'ERRO: impossivel abrir sessão na BaseX'})

            try:
                file_query = open(os.path.join(BASE_DIR, "app", "static","xml","change_email.xq"),'r')
                query = file_query.read().replace("var1",request.user.email).replace("var2",mail)

                queryResult = session.query(query)
                queryResult.execute()
                queryResult.close()
                User.objects.filter(username=username).update(email=mail)

            except Exception as e:
                return render(request, 'erro.html', {"erro":e})
            
            finally:
                queryResult.close()
                if session:
                    session.close()
            
    return HttpResponseRedirect(reverse('conta'))
    

#********************* 7 DAY WEATHER WIDGET ********************************
#*****************************************************************************
def forecast_city(request):
    if 'cityText' in request.POST or 'name' in request.GET:
        if 'cityText' in request.POST:
            city_name=request.POST['cityText']
            city_id= findCityId(city_name)
        else:
            city_name = request.GET['name']
            city_id = findCityId(city_name)
        
        if city_id!=0:
            url_forecast = 'http://servicos.cptec.inpe.br/XML/cidade/7dias/'+str(city_id)+'/previsao.xml'
            with urlopen(url_forecast) as d:
                xml_forecast = etree.parse(d)

            #Template da previsão dos 7 dias
            xslt_path = os.path.join(BASE_DIR, "app", "static","xml","previsao_7days.xsl")
            xslt_file = etree.parse(xslt_path)
            transform = etree.XSLT(xslt_file)
            forecast_template = transform(xml_forecast)

            #Template para mudar a imagem dinamicamente
            xslt_path = os.path.join(BASE_DIR, "app", "static","xml","previsao_image.xsl")
            xslt_file = etree.parse(xslt_path)
            transform = etree.XSLT(xslt_file)
            image_template = transform(xml_forecast)
            data_pt = day_card()

            if request.user.is_authenticated:
                city_on_bd = verify_if_city_bd(request.user.email, city_name)

                context = {
                    'city_name':city_name,
                    'forecast':forecast_template,
                    'image': image_template,
                    'day': data_pt,
                    'city_bd' : str(city_on_bd)
                }
            else:
                context = {
                    'city_name':city_name,
                    'forecast':forecast_template,
                    'image': image_template,
                    'day': data_pt,
                }

        else:
            context = {
                'forecast':"Cidade inexistente no Brasil",
            }

    else:
        context= {
            'forecast':"Tem que escolher uma cidade!"
        }

    return render(request, 'weather_card.html', context)

#*********************************************************************************************
def waves_card(request):
    
    if 'cityText' in request.POST or 'name' in request.GET:
        if 'cityText' in request.POST:
            city_name=request.POST['cityText']
            city_id= findCityId(city_name)
        else:
            city_name=request.GET['name']
            city_id= findCityId(city_name)
        if city_id!=0:
            url_ondas = 'http://servicos.cptec.inpe.br/XML/cidade/'+ str(city_id) +'/todos/tempos/ondas.xml'
            try:
                with urlopen(url_ondas) as d:
                    xml_ondas = etree.parse(d)

                #Template da ondulação
                xslt_path = os.path.join(BASE_DIR, "app", "static","xml","ondulacao.xsl")
                xslt_file = etree.parse(xslt_path)
                transform = etree.XSLT(xslt_file)
                ondas_template = transform(xml_ondas)

                xslt_path = os.path.join(BASE_DIR, "app", "static","xml","previsao_mar.xsl")
                xslt_file = etree.parse(xslt_path)
                transform = etree.XSLT(xslt_file)
                image_template = transform(xml_ondas)

                session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
                query = "let $us := doc('users') for $u in $us//user let $cs := $u/comentarios/comentario for $c in $cs where $c[@cidade = " + str(city_id) + "] return ($c/text(), data($c/@data), $u/mail/text())"

                queryResult = session.query(query)
                coments = []
                data = []
                i=0
                # loop through all results
                for typecode, item in queryResult.iter():
                    data += [item]
                temp = []
                count = 0
                for i in data:
                	temp += [i]
                	if count == 2:
                		count= 0
                		coments += [temp]
                		temp = []
                	else:
                		count+=1
                
                for c in coments:
                	User  = get_user_model()
                	users = User.objects.all()
                	for u in users:
                		if u.email == c[2]:
                			c[2] = u.username

                # close query object
                queryResult.close()
                session.close()

                context = {
                    'city_name': city_name,
                    'forecast': ondas_template,
                    'image': image_template,
                    'day': day_card(),
                    'coments': coments,
                    'city_id': city_id,
                }

            except:
                context = {
                    'city_name': city_name,
                    'forecast': '',
                    'image': '',
                    'day': day_card(),
                }
        else:
            context = {
                'day':day_card(),
                'forecast': 'Cidade Inválida!',
            }
    else:
        context= {
            'forecast':"Tem que escolher uma cidade!",
            'day':day_card(),
        }

    return render(request, 'ondulacao.html', context)

#*********************************************************************************************
def addComent(request):
    name = request.POST['cityText']
    city_id = request.POST['cityid']
    coment = request.POST['coment']
    today = date.today()
    data = "" + str(today.day) + "/" + str(today.month) + "/" + str(today.year)

    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
    file_schema = open(os.path.join(BASE_DIR, "app", "static","xml","validComent.xsd"),'r')
    input = "let $doc := <comentario data=\"" + data + "\" cidade=\""+ city_id + "\">" + coment + "</comentario> let $schema :=" + file_schema.read() + " return validate:xsd($doc, $schema)"
    query1 = session.query(input)
    try:
        query1.execute()
        query1.close()
    except Exception as e:
        query1.close()
        alert="ERRO: Comentário inválido!"
        return render(request, 'erro.html', {"erro":alert})

    query = "let $us := doc('users') for $u in $us//user where lower-case($u/mail) = '" + request.user.email + "' return insert nodes (<comentario data=\"" + data + "\" cidade=\""+ city_id + "\">" + coment + "</comentario>) as last into $u/comentarios"
    try:
        queryResult = session.query(query)
        queryResult.execute()
        queryResult.close()
    except:
        queryResult.close()
        alert="ERRO: Erro ao guardar comentário!"
        return render(request, 'erro.html', {"erro":alert})

    session.close()

    return HttpResponseRedirect(reverse('ondulacao') + '?name=' + name)

#*********************************************************************************************
def signup(request):
    if request.method == 'POST':
        form = SignUpForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            raw_password = form.cleaned_data.get('password1')
            user = authenticate(username=username, password=raw_password)
            login(request, user)
            session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
            file_schema = open(os.path.join(BASE_DIR, "app", "static","xml","validUser.xsd"),'r')
            input = "let $doc := <user>  <mail>" +user.email +"</mail> </user> let $schema :=" + file_schema.read() + " return validate:xsd($doc, $schema)"
            query1 = session.query(input)
            try:
                query1.execute()
                query1.close()
                input2 = "let $us := doc('users') for $u in $us/users/user[last()] return insert node <user> { <mail>" +user.email +"</mail>, <cidades></cidades>, <comentarios></comentarios> } </user> after $u"
                query2 = session.query(input2)
                query2.execute()
                query2.close()
            except Exception as e:
                query1.close()
                alert=e
                return render(request, 'erro.html', {"erro":alert})
            session.close()
            return redirect('index')
    else:
        form = SignUpForm()
    return render(request, 'signup.html', {'form': form})

#*********************************************************************************************
def myaccount(request):
    context={
    }
    return render(request, 'myaccount.html', context) 

#*********************************************************************************************
def favoritos(request):
    favorite = favorite_cities_info(request.user.email)

    return render(request, 'favoritos.html', {'favorite' : favorite })



#*********************
# Funções Auxiliares #
#*********************



def findCityId(city_name):
    
    city_id = 0
    city_name=unicodedata.normalize('NFD', city_name.lower())\
        .encode('ascii', 'ignore')\
        .decode("utf-8")
    c_n=re.sub(r"[^\w\s]", '', city_name)
    c_n=re.sub(r"\s+", '%20', c_n)

    url_city="http://servicos.cptec.inpe.br/XML/listaCidades?city="+c_n
    f = urlopen(url_city).read()

    xml_city=etree.fromstring(f)

    query = "//cidades/cidade"

    cities = xml_city.xpath(query)

    for c in cities:
        name = c.find('nome').text.lower()
        name = unicodedata.normalize('NFD', name)\
            .encode('ascii', 'ignore')\
            .decode("utf-8")
        if name == city_name:
            city_id = c.find('id').text

    return city_id

#*************************************************************************************
def day_card():
    today = date.today()
    d2 = today.strftime("%d %B")
    data = d2.split()

    for item in data:
        if item == 'January':
            data[1] = 'de Janeiro'
        if item == 'February':
            data[1] = 'de Fevereiro'
        if item == 'November':
            data[1] = 'de Novembro'
        if item == 'December':
            data[1] = 'de Dezembro'
        if item == 'March':
            data[1] = 'de Março'
        if item == 'April':
            data[1] = 'de Abril'
        if item == 'May':
            data[1] = 'de Maio'
        if item == 'June':
            data[1] = 'de Junho'
        if item == 'July':
            data[1] = 'de Julho'
        if item == 'August':
            data[1] = 'de Agosto'
        if item == 'September':
            data[1] = 'de Setembro'
        if item == 'October':
            data[1] = 'de Outubro'

    data_pt = " ".join(data)


    return data_pt

#*************************************************************************************
def favorite_cities_info(email):
    favorite = dict()
    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')

    if not session:
        return render(request, 'erro.html', {"erro":'ERRO: Impossível abrir sessão na BaseX'})

    #Buscar as cidades favoritas de um determinado utilizador
    try:
        query = "let $us := doc('users') for $u in $us//user where $u/mail = '"+email+"'  return data($u/cidades/cidade/nome)"
        queryResult = session.query(query)

        #Adicionar ao dicionário das cidades favoritas
        for typecode, city_name in queryResult.iter():
            key = city_name
            id = findCityId(city_name)
            url_city = "http://servicos.cptec.inpe.br/XML/cidade/7dias/"+ id +"/previsao.xml"
            f = urlopen(url_city).read()
            xml_city = etree.fromstring(f)

            #Buscar primeira previsão do tempo
            query = "/cidade/previsao[1]"
            citie = xml_city.xpath(query)

            for c in citie:
                current_weather = c.find('iuv').text
                max_temp = c.find('maxima').text
                min_temp = c.find('minima').text

            url_city_ondas = "http://servicos.cptec.inpe.br/XML/cidade/" + id + "/todos/tempos/ondas.xml"
            try:
                file = urlopen(url_city_ondas).read()
                xml_city_wave = etree.fromstring(file)

                # Buscar as condições de mar
                query1 = "/cidade/previsao[1]"
                waves = xml_city_wave.xpath(query1)

                for w in waves:
                    sea_state = w.find('agitacao').text
            except:
                    sea_state = "Sem informação"


            #Dicionário da cidade: key=(nome da cidade) values=(são os dados do dia de hoje)
            favorite[key] = [current_weather, max_temp, min_temp, sea_state]

    # Fechar sessão
    finally:
        if session:
            session.close()

    return favorite

#*************************************************************************************
def add_favorite_citie(request):
    city_name = request.POST['cityText']
    city_id = findCityId(city_name)
    bd_cities_empty = verify_empty_cities_bd(request.user.email)
    if bd_cities_empty is None:
        return render(request, 'erro.html', {"erro":'ERRO: algo aconteceu na verificação da base de dados'})

    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
    if not session:
        return render(request, 'erro.html', {"erro":'ERRO: Impossivel criar sessão no BaseXServer '})

    try:
        query = "let $us := doc('users') for $x in $us/users/user where $x/mail = '"+request.user.email+"' return insert node <cidade> { <id>" + city_id + "</id>, <nome>" + city_name + "</nome> } </cidade> into $x/cidades"

        queryResult = session.query(query)
        queryResult.execute()
        queryResult.close()
    finally:
        if session:
            session.close()

    return HttpResponseRedirect(reverse('forecast_city') +'?name=' + city_name)

#*************************************************************************************
def remove_favorite_cities(request):
    name = request.POST['cityText']

    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')
    if not session:
        return render(request, 'erro.html', {"erro":'ERRO: Impossivel criar sessão no BaseXServer!'})

    try:
        query = "let $us := doc('users') for $u in $us//user where $u/mail = '"+ request.user.email+ "' let $xs := $u//cidade for $x in $xs where $x/nome = '"+name+"' return delete node $x"
        queryResult = session.query(query)
        queryResult.execute()
        queryResult.close()

    finally:
        if session:
            session.close()

    return HttpResponseRedirect(reverse('favoritos') +'?name=' + name)

#*************************************************************************************
def verify_empty_cities_bd(email):
    check = 0
    bd_empty = None
    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')

    if not session:
        return render(request, 'erro.html', {"erro":'ERRO: Impossivel criar sessão no BaseXServer!'})

    try:
        query = "let $us := doc('users') for $u in $us//user where lower-case($u/mail) = '"+email+"' for $c in $u return $c/cidades"
        queryResult = session.query(query)


        for type, item in queryResult.iter():
            check += 1

        if check > 1: #Ter a certeza que está mesmo vazia
            bd_empty = False
        else:
            bd_empty = True

        queryResult.execute()
        queryResult.close()

    finally:
        if session:
            session.close()

    return bd_empty

#*************************************************************************************
def verify_if_city_bd(email,city_name):
    city_bd = False
    session = BaseXClient.Session('localhost', 1984, 'admin', 'admin')

    if not session:
        return render(request, 'erro.html', {"erro":'ERRO: Impossivel criar sessão no BaseXServer!'})

    try:
        query = "let $us := doc('users') for $x in $us/users/user where $x/mail = '"+email+"' for $c in $x//cidade where $c/nome = '"+city_name+"' return data($c/nome)"
        queryResult = session.query(query)

        for type, item in queryResult.iter():
            city_bd = True

        queryResult.execute()
        queryResult.close()

    finally:
        if session:
            session.close()

    return city_bd

