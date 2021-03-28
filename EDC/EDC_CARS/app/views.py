from django.shortcuts import render
from rdflib import Graph
from SPARQLWrapper import SPARQLWrapper, JSON, N3
from django.http import JsonResponse
from django.http import HttpResponseRedirect
from django.urls import reverse
from s4api.graphdb_api import GraphDBApi
from s4api.swagger import ApiClient
import json
import math

endpoint = "http://localhost:7200"
repo_name = "cars"
client = ApiClient(endpoint=endpoint)
accessor = GraphDBApi(client)

# Create your views here.
def main(request):

    context = {'manufacturers': []}

    query = ('''
        PREFIX dbr: <http://dbpedia.org/resource/>
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select distinct ?manufacturer
        where{
            
            ?car dbo:manufacturer ?man .
            ?man rdfs:label ?manufacturer .

        }
        ''')
    
    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    res = json.loads(res)
    binds = [b for b in res['results']['bindings']]
    manufacturersInfo = [info['manufacturer'] for info in binds]
    manufacturers = [manufacturer['value'] for manufacturer in manufacturersInfo]

    context['manufacturers'] = manufacturers

    return render(request, 'index.html', context=context)

############################################################################

def car(request):

    if 'name' not in request.POST:
        return HttpResponseRedirect(reverse('main'))


    if 'editCar' in request.POST:
        return edit_car(request)
    else:
        name = request.POST.get('name')

        query = ('''
            PREFIX foaf: <http://xmlns.com/foaf/0.1/>
            PREFIX dbo: <http://dbpedia.org/ontology/>
            PREFIX dbr: <http://dbpedia.org/resource/>
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
            PREFIX dbp: <http://dbpedia.org/property/>
            SELECT ?abstract ?pSy ?transmission ?weight ?man ?length ?height ?width ?class ?manuf ?car
            WHERE {

                ?car rdfs:label "'''+name+'''"@en .
                OPTIONAL{ ?car dbo:abstract ?abstract .
                    FILTER(lang(?abstract) = 'en') . }
                OPTIONAL{?car dbo:manufacturer ?manuf .
                    ?manuf rdfs:label ?man .}
                OPTIONAL{?car dbo:productionStartYear ?pSy .} 
                OPTIONAL{?car dbo:transmission ?transmission .}
                OPTIONAL{?car dbo:weight ?weight .}
                OPTIONAL{?car dbo:length ?length .}
                OPTIONAL{?car dbo:height ?height .}
                OPTIONAL{?car dbo:width ?width .}
                OPTIONAL{?car dbp:class ?class .}

            }
            ''')

        payload_query = {"query": query}
        res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
        res = json.loads(res)

        binds = [b for b in res['results']['bindings']]
        if 'abstract' in binds[0]:
            abstract = binds[0]['abstract']['value']
        else:
            abstract = 'no abstract'
        if 'man' in binds[0]:
            man = binds[0]['man']['value']
        else:
            man = 'no value assigned'
        if 'pSy' in binds[0]:
            pSy = binds[0]['pSy']['value'].split("-")[0]
        else:
            pSy = 'no value assigned'
        if 'transmission' in binds[0] and len(binds[0]['transmission']['value']) > 1:
            transmission = binds[0]['transmission']['value']
        else:
            transmission = 'no transmission value assigned'
        if 'weight' in binds[0] and len(binds[0]['weight']['value']) > 1:
            peso = str(math.floor(float(binds[0]['weight']['value']) / 1000)) + ' Kg'
        else:
            peso = 'no weight value assigned'
        if 'length' in binds[0] and len(binds[0]['length']['value']) > 1:
            length = binds[0]['length']['value']+ " m"
        else:
            length = 'no length value'
        if 'width' in binds[0] and len(binds[0]['width']['value']) > 1:
            width = binds[0]['width']['value']+ " m"
        else:
            width = 'no width value'
        if 'height' in binds[0] and len(binds[0]['height']['value']) > 1:
            height = binds[0]['height']['value'] + " m"
        else:
            height = 'no height value'
        if 'class' in binds[0] and len(binds[0]['class']['value']) > 1:
            clasInfo = [bind['class']['value'] for bind in binds if len(bind['class']['value']) > 1]
            clas = ''
            for f in clasInfo:
                if f not in clas:
                    clas += f + ", "
        else:
            clas = 'no class value'
        if 'manuf' in binds[0]:
            man_uri = binds[0]['manuf']['value']
        else:
            man_uri = ""
        if 'car' in binds[0]:
            car_uri = binds[0]['car']['value']
        else:
            car_uri = ""

        context = {'car_name': name, 'abstract' : abstract, 'pSy': pSy,
            'transmission': transmission, 'peso': peso, 'man': man, 'length':length,
            'height': height, 'width': width, 'class': clas, 'man_uri': man_uri, 'car_uri': car_uri}

        return render(request, 'carDetail.html', context=context)

############################################################################

def add_car(request):
    query = ("""
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        SELECT distinct ?brands
        WHERE {
            ?s dbo:manufacturer ?o .
            ?o rdfs:label ?brands .
        }		
    """)
    
    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    make = []
    result = json.loads(res)
    binds = [b for b in result['results']['bindings']]
    for man in binds:
        make.append(man['brands']['value'])



    context = {'manufacturers': make}


    return render(request, 'add_car.html', context)

############################################################################
def edit_car(request):

    name = request.POST.get('name')

    query = ('''
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

            SELECT ?car ?p ?o
            WHERE {
                ?car rdfs:label "'''+name+'''"@en .
                ?car ?p ?o .
            }
            ''')

    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    res = json.loads(res)
    dict_triples=[]
    binds = [b for b in res['results']['bindings']]
    for b in binds:
        dict_triples.append( [ name, b['p']['value'], b['o']['value'] ] )

    context={'name': name, 'dict':dict_triples}

    return render(request, 'edit_car.html', context)


############################################################################

def submit_car(request):

    man = "dbr:" + request.POST['man']
    model = request.POST['model']
    start = "'" + request.POST['start']+ "'" #+ "^^xsd:gYear"

    height ='"'+ request.POST['height'] + '"' #+ "^^ns8:millimetre"
    width = "'"+ request.POST['width'] + "'" #+ "^^ns8:millimetre"
    length ="'"+ request.POST['length'] + "'" #+ "^^ns8:millimetre"
    weight="'"+ request.POST['weight'] + "'" # + "^^ns8:kilogram" 
    classs= "'" + request.POST['classs'] + "'"
    fuel= "'" + request.POST['fuel'] + "'"
    abstract = "'" + request.POST['abstract'] + "'"


    update = ("""
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX dbr: <http://dbpedia.org/resource/>PREFIX mov:<http://movies.org/pred/>
        PREFIX dbp: <http://dbpedia.org/property/>
        INSERT DATA
        {
        """)+("dbr:"+model.replace(" ","_"))+(""" 	dbo:manufacturer """)+(man)+(""" ;

            dbo:productionStartYear	""")+(start)+(""";
            dbo:height				""")+(height)+(""";
            dbo:width				""")+(width)+(""";
            dbo:length				""")+(length)+(""";
            dbo:weight				""")+(weight)+(""";	
            dbp:class			    """)+(classs)+(""";
            dbp:class			    """)+(fuel)+(""";
            rdfs:label              """ + ('"'+model+'"')+"""@en;
            dbo:abstract			""" + abstract +"""@en.
        }
        """)
    
    payload_query = {"update": update}
    res = accessor.sparql_update(body=payload_query,repo_name=repo_name)


    return HttpResponseRedirect(reverse('main'))


############################################################################
def submit_edit_car(request):
    car = request.POST['car_name']
    pred = request.POST['predicate']
    oldObject = request.POST['oldObject']
    newObject = request.POST['newObject']

    update = ('''
            PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

            DELETE
            {
                ?car <'''+ pred +'''> "'''+oldObject+'''"@en .
            }
            INSERT
            {
                ?car <'''+ pred +'''> "'''+newObject+'''"@en .
            }
            WHERE{

                ?car rdfs:label "'''+car+'''"@en .
                
            }
    ''')
    
    payload_query = {"update": update}
    res = accessor.sparql_update(body=payload_query,repo_name=repo_name)

    return HttpResponseRedirect(reverse('main'))

############################################################################

def brands(request):

    context = {'manufacturers': []}

    query = ('''
        PREFIX dbr: <http://dbpedia.org/resource/>
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select distinct ?manufacturer
        where{
            
            ?car dbo:manufacturer ?man .
            ?man rdfs:label ?manufacturer .

        }
        ''')
    
    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    res = json.loads(res)
    binds = [b for b in res['results']['bindings']]
    manufacturersInfo = [info['manufacturer'] for info in binds]
    manufacturers = [manufacturer['value'] for manufacturer in manufacturersInfo]

    context['manufacturers'] = manufacturers

    return render(request, 'brands.html', context=context)

############################################################################

def brandDetail(request, name):

    sparql = SPARQLWrapper('https://dbpedia.org/sparql')

    sparql.setQuery('''
        PREFIX dbr: <http://dbpedia.org/resource/>
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select distinct ?abstract ?foundDate ?founder ?man
        where{
            
            ?man rdfs:label "''' + name +'''"@en .
            OPTIONAL{?man dbo:abstract ?abstract .
                FILTER(LANG(?abstract)='en') .}
            OPTIONAL{?man dbo:foundedBy ?founderRes .
                ?founderRes rdfs:label ?founder .
                FILTER(LANG(?founder)='en') .}
            OPTIONAL{?man dbo:foundingDate ?foundDate .}

        }
        ''')
    
    sparql.setReturnFormat(JSON)
    res = sparql.query().convert()

    binds = [b for b in res['results']['bindings']]
    if 'abstract' in binds[0]:
        abstract = binds[0]['abstract']['value']
    else:
        abstract = 'no abstract'
    if 'foundDate' in binds[0] and len(binds[0]['foundDate']['value']) > 1:
        foundDate = binds[0]['foundDate']['value']
    else:
        foundDate = 'No date assigned'
    if 'founder' in binds[0] and len(binds[0]['founder']['value']) > 1:
        founderInfo = [bind['founder']['value'] for bind in binds if 'founder' in bind and len(bind['founder']['value']) > 1]
        founder = ''
        for f in founderInfo:
            if f not in founder:
                founder += f + ", "
    else:
        founder = 'No founder value'
    if 'man' in binds[0]:
        man_uri = binds[0]['man']['value']
    else:
        man_uri = ""

    context = {'name': name, 'abstract': abstract, 'founder': founder, 'foundDate': foundDate, 'man_uri': man_uri}

    return render(request, 'brandDetail.html', context=context)

############################################################################



############################################################################
# Funções Auxiliares
############################################################################

def load_cars(request):

    man = request.GET.get('man',None)

    query = ('''
        PREFIX dbr: <http://dbpedia.org/resource/>
        PREFIX dbo: <http://dbpedia.org/ontology/>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select ?car_name
        where{
            
            ?man rdfs:label "'''+man+'''"@en .
            ?car dbo:manufacturer ?man .
            ?car rdfs:label ?car_name .
        }
    ''')

    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    res = json.loads(res)

    binds = [b for b in res['results']['bindings']]
    models = [model['car_name'] for model in binds]

    context = {'models': [value['value'] for value in models]}

    return JsonResponse(context)

############################################################################

def load_cars_inference(request):

    typeInf = request.GET.get('typeInf',None)

    if typeInf == 'Classic':
        update = ('''
            PREFIX dbr: <http://dbpedia.org/resource/>
            PREFIX dbo: <http://dbpedia.org/ontology/>

            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
            insert {?s rdf:type "Classic"}
            where{
                ?s dbo:productionStartYear ?o .
                FILTER(str(?o) <= "1960") .
            }
        ''')
    elif typeInf == 'Ecologic':
        update = ('''
            PREFIX dbr: <http://dbpedia.org/resource/>
            PREFIX dct: <http://purl.org/dc/terms/>
            PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
            insert {?car rdf:type "Ecologic"}
            where{
                ?car dct:subject ?s .
                FILTER regex(?s, "electric", "i") .
            }
        ''')

    payload_query = {"update": update}
    res = accessor.sparql_update(body=payload_query,repo_name=repo_name)

    context = selectInfered(typeInf)

    return JsonResponse(context)

############################################################################

def selectInfered(typeInf):

    query = ('''
        PREFIX dbr: <http://dbpedia.org/resource/>
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select ?car_name
        where{
            ?car rdf:type "''' + typeInf + '''" .
            ?car rdfs:label ?car_name .
        }
    ''')

    payload_query = {"query": query}
    res = accessor.sparql_select(body=payload_query,repo_name=repo_name)
    res = json.loads(res)

    binds = [b for b in res['results']['bindings']]
    models = [model['car_name'] for model in binds]
    context = {'models': [value['value'] for value in models]}

    return context

############################################################################