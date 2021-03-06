# codingmonamour.org

*codingmonamour* è una applicazione scritta in [**Ruby**](http://www.ruby-lang.org/it/) usando il microframework [*Sinatra*](http://www.sinatrarb.com/). Per rendere le cose più semplici possibile e senza fornirla di un *back-end* per la scrittura dei documenti si è scelto di automatizzare alcuni meccanismi.
Download github repository: [master](https://github.com/minimalprocedure/codingmonamour/archive/master.zip)

## documenti

I documenti devono essere scritti in *markdown*, un sistema molto semplice per definire il formato delle pagine usando soltando dei semplici file di testo. Il *markdown* essendo un del semplice testo è elaborabile con qualunque editor: dal demenziale *notepad* di Microsoft Windows passando per editor specializzati e fino a Vim o Emacs.

Ci sono molti editor specializzati e multipiattaforma:

1. [WiterMonkey](http://writemonkey.com)
2. [Haropad](http://pad.haroopress.com/user.html)
3. [MarkPad](http://code52.org/DownmarkerWPF/)
4. [MarkdownPad](http://www.markdownpad.com/)
5. [ReText](https://github.com/retext-project/retext/wiki/Installing-ReText)
6. [Dillinger](http://dillinger.io/)
7. [iA](https://ia.net/writer)
8. [78 Tools for Writing and Previewing Markdown](http://mashable.com/2013/06/24/markdown-tools/#s6x722wUFZqm)

Un convertitore di documenti molto potente: [pandoc](http://pandoc.org/)

Il markdown è elaborato da una libreria che si chiama [kramdown](https://kramdown.gettalong.org/) che pemette alcune estensioni come per esempio la possibilità di usare dei metadati interni per definire gli stili da applicare ai blocchi: [block attributes](https://kramdown.gettalong.org/quickref.html#block-attributes).

I documenti possono essere associati a dei metadati in formato [**YAML**](http://yaml.org/). Per esempio se un un documento si chiama *0.chi-siamo.markdown* si potrà associare un file come *0.chi-siamo.yml*.

Il file di metadati associato potrà avere varie chiavi:

~~~
---
document:
  title: Coding Mon Amour
  language: it
  keywords: programming, coding, Scratch
  description: programming and coding
  author: codingmonamour, pippo, pluto
  date: 2016-12-16
  links:
    - Test=/test
  metas:
    - aaa=bbb
~~~

La radice dovrà essere *document* (esiste anche un altro file di metadati della applicazione la cui radice sarà: *application*). La chiave *links* serve per aggiungere voci al menù principale dopo quelle create automaticamente in base ai file presenti nella cartella corrente.

Caricando un *url* del tipo *http://domino.com/test/pippo*, la cartella corrente sarà *test* ed il documento caricato *[numero per l'ordine]-pippo.markdown*.

Il file di metadati è opzionale ma nel caso verà unito a quello dell'applicazione che risiede in: *application/metadata.yml*

La chiave *metas*, se presente, contribuirà a formare dei *tag* *meta* (oltre quelli predefiniti nel layout) nella intestazione della pagina (utile per eventualmente creae dei *meta* per vari social).

Nei metadati del documento si può usare una chiave *load* con il percorso di un file relativo alla radice della applicazione, in questo caso il documento caricato sarà quello indicato. Se per esempio abbiamo nell cartella *help* un file *index.yml* in questo modo:

~~~
---
document:
  title: Help
  language: it
  keywords: programming, coding, Scratch
  description: programming and coding
  author: ghisalberti
  date: 2016-12-18
  load: README.md
~~~

chiamando *http://dominio.com/help* verrà caricato il file README.md posizionato sulla radice della applicazione.

Per quello che riguarda i metadati della applicazione:

~~~
---
application:
  title: Coding Mon Amour
  language: it
  keywords: programming, coding
  date: 2016-12-10
  home: 
    name: 'Home'
    document: index
~~~

la struttura è la stessa a parte la chiave *home* che viene utilizzata per definire il nome che verrà usato per il file predefinito di radice ed il nome del file.
Chiamando per esempio *http://dominio.com/test* il file caricato sarà in questo caso: *index.markdown*.

### percorsi

I percorsi sono delle semplici sottocartelle di *documents* ed i documenti verranno serviti col semplice percorso nell'url. Chiamando *http://dominio.com/aaa/bbb/ccc/pippo* il file caricato sarà: *[documents]/aaa/bbb/ccc/pippo.markdown*.
Le cartelle saranno fatte a mano all'occorrenza ed i file markdown insieme ai loro metadati, saranno inseriti in quelle. Niente back-end, ma tutto manuale con un po' di automazione.

## menù principale

Il menù principale è costruito in maniera automatica in base ai file presenti nella cartella corrente e si adatterà in relazione al contenuto della cartella.

In caso di una struttura come questa:

~~~
documents
	index.markdown
    0.chi-siamo.markdown
    1.dove-andiamo.markdown
    progetti
    	index.markdown
        0.progetto-1.markdown
        1.progetto-2.markdown
        2.progetto-3.markdown
~~~
Il menù sulla radice del sito web, sarà: *Home, chi siamo, dove andiamo*; mentre chiamando *http://dominio.com/progetti* sarà: "Home, progetto 1, progetto 2, progetto 3*. *Home* porterà sempre alla radice del sito web.

## layout principale

Il layout delle pagine è un file in [Slim](http://slim-lang.com/) e risiede nella cartella *documents/layouts*. Modificatelo solo se conoscete lo Slim.

## Gli stili css

Ci sono due stili css, uno (*application.css*) della applicazione (statico) nella cartella *public/stylesheets* ed uno (documents.scss) dei documenti nella cartella *documents*. Lo stile dei documenti è in formato [SCSS](http://sass-lang.com/).

## file pubblici

Nella cartella *public* ci sono i file *pubblici* e quelli non elaborati dalla applicazione (come i file css per gli stili delle pagine o i javascript, ma anche altri file in html che dovranno essere chiamati sempre con l'estensione html nell'url).

## file della applicazione

Tutti i file al di fuori della cartella *documents* e della *public* (a parte il file di metadati generale: *application/metadata.yml*) sono da considerare privati e non andrebbero modificati a meno di: **sapere cosa si stia facendo**.

## esecuzione

Come già stato detto è una applicazinoe scritta in Ruby, quindi occorre un runtime Ruby er eseguirla. Alcune librerie che sono richieste sono *native* e dovranno essere compilate in fase di installazione. Questo potrebbe creare qualche problema con Microsoft Windows. Nel caso di questo sistema operativo installare Ruby da questo sito web: [RubyInstaller](http://rubyinstaller.org/).
Per Linux o per MacOSX non dovrebbero esserci problemi particolari.
Dopo aver installato Ruby va caricata una *gemma* (libreria di codice in Ruby) con il comando: 

~~~
gem install bundler
~~~

[*Bundler*](http://bundler.io/) è un gestore per le *gemme* Ruby in relazione all'applicazione e serve per la risoluzione delle dipendenze e versioni di librerie (la libreria A dipende da B ma nella versione 1.2 e non 1.3).
Per lanciare l'applicazione che servirà all'indirizzo: *http://[ip della macchina]:3000*, usare il comando *start.sh* (su Linux) oppure:

~~~
bundle exec rackup --port 3000 --host 0.0.0.0
~~~



