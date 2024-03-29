<TeXmacs|1.0.7.10>

<style|generic>

<\body>
  <doc-data|<doc-title|Algorithmen zur Visualisierung von Graphen>>

  <section|Einf�hrung>

  <\description>
    <item*|Informationsvisualisierung>(Graphenvisualisierung ist ein
    Spezialfall davon) Drei wesentliche Aspekte: <em|Informationsgehalt> der
    zu visualisierenden Daten, <em|Design> der Visualisierung,
    <em|Algorithmen> zur Realisierung des Designs

    <item*|Repr�sentationen>Abbildungsvorschrift, die zu jedem Datenelement
    angibt, durch was f�r ein graphisches Element (Punkt, Linie, Fl�che,
    K�rper) es dargestellt wird.

    <\itemize-dot>
      <item>Standardrepr�sentation: Knoten <math|\<rightarrow\>> Punkte,
      Kanten <math|\<rightarrow\>> Linien

      <item>Inklusionsrepr�sentation: Knoten <math|\<rightarrow\>> Fl�chen,
      Kanten implizit

      <item>Ber�hrungsrepr�sentation: Knoten <math|\<rightarrow\>> Fl�chen,
      Kanten implizit

      <item>Intervallrepr�sentation: Knoten <math|\<rightarrow\>> Linien,
      Kanten implizit

      <item>Sichtbarkeitsrepr�sentation: Knoten <math|\<rightarrow\>> Linien.
      Kanten <math|\<rightarrow\>> Linien
    </itemize-dot>

    <item*|Beschreibung von Layouteigenschaften>Allgemein, da zu
    visualisierende Daten im Voraus nicht bekannt sind.

    <\description>
      <item*|Nebenbedingungen>M�ssen auf jeden Fall erf�llt sein (z.B.
      Planarit�t)

      <item*|G�tekriterien>M�ssen soweit wie m�glich erf�llt sein (z.B.
      minimale Knickanzahl)
    </description>
  </description>

  <section|Kr�ftebasierte Verfahren>

  Benutzen physikalische Analogien zum Zeichnen von Graphen.

  <\description>
    <item*|Spring Embedder>Kanten verhalten sich �hnlich zu Federn:

    <\itemize>
      <item>Absto�ende Kraft <math|f<rsub|rep>> zwischen nicht adjazenten
      Knoten, umgekehrt proportional zur Distanz

      <item>Anziehende Kraft <math|f<rsub|spring>> zwischen adjazenten
      Knoten, logarithmisch in der Distanz.
    </itemize>

    Ziel: Gleichgewichtszustand, in dem sich alle Kr�fte eines Knotens zu
    Null summieren

    <math|\<rightarrow\>>Iterative Methoden

    <item*|Klassischer Spring Embedder>Berechne iterativ Verschiebevektor f�r
    jeden Knoten, bis alle Verschiebevektoren hinreichend klein sind oder
    eine festgelegte Anzahl an Iterationen durchlaufen wurde.

    <strong|Vorteile>: simpel, liefert f�r kleine/mittelgro�e Graphen gute
    Ergebnisse

    <strong|Nachteile:> m�glicherweise nicht stabil, H�ngenbleiben in lokalem
    Minimum

    Laufzeit in <math|O<around*|(|n\<cdot\><around*|(|<around*|\||E|\|>+<around*|\||V|\|><rsup|2>|)>|)>>
    (<math|n> Anzahl der Iterationen)

    <item*|Fruchterman und Reingold (FR)><math|f<rsub|rep>> wirkt nun auch
    zwischen adjazenten Knoten, neue anziehende Kraft <math|f<rsub|attr>>
    (quadratisch in der Diestanz) zwischen adjazenten Knoten

    Federkraft <math|f<rsub|spring>=f<rsub|rep>+f<rsub|attr>>, schnellere
    Konvergenz durch quadratisches Anwachsen der Kraft <math|\<rightarrow\>>
    effizienteres Verfahren

    <item*|Graph Embedder (GEM)>Variante von FR

    <\itemize>
      <item>Bewege \Rschwere`` Knoten (hoher Grad) langsamer als \Rleichte``

      <item>Neue Kraft <math|f<rsub|grav>> zieht alle Knoten in Richtung des
      Schwerpunktes <math|\<rightarrow\>> kein Auseinanderdriften von
      Zusammenhangskomponenten

      <item>Besuchen der Knoten in zuf�lliger Reihenfolge pro Iteration

      <item>Entdeckung von Oszillationen (durch Verkleinerung der
      Verschiebekonstanten, wenn Knoten in entgegengesetzter Richtung wie in
      der vorherigen Iteration bewegt wird) und Rotationen (\RDrehanzeiger``
      und Verringerung der Verschiebekonstanten)
    </itemize>

    <item*|Weitere Heuristiken zur Effizienzsteigerung>

    <\description>
      <item*|Grid-Technik>Ignorieren von weit entfernten Knoten (da diese
      nicht viel zur Verschiebung eines Knotens beitragen): Laufzeit bei
      gleichm��iger Verteilung in <math|O<around*|(|<around*|\||V|\|>+<around*|\||E|\|>|)>>
      pro Iteration.

      <item*|Verschiebefaktor anpassen>Gegen Ende (wenn Zustand fast stabil
      ist) wird der Verschiebefaktor verringert.

      <item*|Vorgegebenen Rahmen einhalten>Clipping eines Knotens, wenn er
      �ber diesen Rahmen hinaus verschoben w�rde.

      <item*|Wahl der idealen Federl�nge <math|l>><math|l=c\<cdot\><sqrt|<frac|Flaeche|<around*|\||V|\|>>>>
      mit zu bestimmender Konstanten <math|c>
    </description>

    <item*|Laufzeitverbesserung>Berechnung der Kr�fte zwischen Knotenpaaren
    <math|O<around*|(|n<rsup|2>|)>\<rightarrow\>O<around*|(|n*log n|)>>

    <\description>
      <item*|Quad-Tree-Datenstruktur>Knoten sind Bl�tter, H�he
      <math|O<around*|(|log n|)>\<rightarrow\>>Aufbau in
      <math|O<around*|(|n*log n|)>>, Berechnung der absto�enden Kr�fte eines
      Knotens in <math|O<around*|(|log n|)>>.

      <item*|Rekursive Berechnung im Quad-Tree>Approximieren von
      <math|f<rsub|rep>> anhand eines G�te-Parameters <math|\<gamma\>> und
      Schwerpunkt der Punkte in einer QT-Region

      Je kleiner <math|\<gamma\>>, desto besser die Approximation und desto
      h�her die Laufzeit. Bei geeigneter Wahl von <math|\<gamma\>> ist die
      Laufzeit pro Knoten in <math|O<around*|(|h<rsub|QT>|)>>, also in
      <math|O<around*|(|log n|)>>.
    </description>

    <item*|Multilevel-Methoden f�r gro�e Graphen>Durch zuf�lliges
    Anfangslayout ergeben sich \RFaltungen``/\R�berlappungen``, die nur durch
    viele Iterationen beseitigt werden k�nnen.

    <math|\<rightarrow\>> Rekursives Vergr�bern des Graphen, Finden eines
    guten Layouts (schnell!), Expandieren des Layouts auf den
    Originalgraphen.

    <\description>
      <item*|Generelle Vorgehensweise>Konstruiere \RVergr�berungen``
      <math|G<rsub|1>,G<rsub|2>,\<ldots\>,G<rsub|k>> von <math|G> mit
      abnehmender Knotenanzahl. Layout von <math|G<rsub|i-1>>: Setze Layout
      von <math|G<rsub|i>> als initiales Layout f�r ein kr�ftebasiertes
      Verfahren, positioniere restliche Knoten z.B. im Schwerpunkt ihrer
      Nachbarknoten (baryzentrisch), berechne Layout von <math|G<rsub|i-1>>.

      <item*|MIS-Vergr�berung (GRIP)>Inklusionsmaximale Knotenmengen
      <math|V=V<rsub|0>\<supset\>\<ldots\>\<supset\>V<rsub|k>>, sodass jedes
      Knotenpaar in <math|V<rsub|i>> f�r <math|i\<gtr\>0> eine Mindestdistanz
      von <math|2<rsup|i-1>+1> in <math|G> hat.

      Logarithmische L�nge, Aufbau von <math|V<rsub|i>> mittels BFS in
      <math|O<around*|(|<around*|\||V<rsub|i-1>|\|>|)>>

      <item*|Matching-Vergr�berung>Rekursive Verkleinerung durch
      Verschmelzung der Endknoten von Matchingkanten zu einem Knoten
      <math|\<rightarrow\>> Reduktion pro Schritt auf die H�lfte (im
      Idealfall). Finden eines Matchings liegt in
      <math|O<around*|(|<around*|\||V|\|>+<around*|\||E|\|>|)>>.
    </description>
  </description>

  <section|Globale und lokale Optimierung>

  Ziel hier wie im vorherigen Kapitel: Weitfl�chige Verteilung der Knoten,
  ohne adjazente Knoten zu weit voneinander zu entfernen.

  <\description>
    <item*|Zielfunktion>Die Layouteigenschaften werden als Kriterien einer
    Zielfunktion behandelt, die mit allgemeinen Optimierungsmethoden
    behandelt werden kann.

    <item*|Zielfunktion f�r kurze Kanten><math|B<around*|(|p|)>=<big-around|\<sum\>|<rsub|<around*|{|u,v|}>\<in\>E>><around*|\<\|\|\>|p<around*|(|u|)>-p<around*|(|v|)>|\<\|\|\>><rsup|2>>,
    <math|p> Vektor der Knotenpositionen. Durch Ableiten (Ableitung 0 als
    notwendige Bedingung f�r ein lokales Minimum) ergibt sich die
    Formulierung mithilfe der <em|Laplace-Matrix>
    <math|L<around*|(|G|)>=D<around*|(|G|)>-A<around*|(|G|)>>, wobei
    <math|D<around*|(|G|)>> auf der Diagonalen die Knotengrade enth�lt und
    <math|A<around*|(|G|)>> die Adjazenzmatrix ist.

    <strong|Problem:> In optimalem Layout liegen alle Knoten einer
    Zusammenhangskomponenten auf einem Punkt <math|\<rightarrow\>> kein
    sinnvolles Layout. Daher sinnvolle Abwandlungen

    <item*|Schwerpunktlayouts>Fixieren der Position einer Teilmenge
    <math|V<rsub|0>\<subseteq\>V> von Knoten

    Falls <math|V<rsub|0>> aus jeder Zusammenhangskomponente von <math|G>
    mindestens einen Knoten enth�lt, gibt es genau ein optimales Layout, das
    durch L�sen eines LGS effizient bestimmt werden kann.

    Notation <math|L<around*|(|G|)><rsup|u v>>: Streichen der zu
    <math|u\<in\>V> geh�rigen Zeile und zu <math|v> geh�rigen Spalte.

    <\description>
      <item*|Matrix-Ger�st-Satz>F�r jeden Multigraphen <math|G> und einen
      beliebigen Knoten <math|v> in <math|G> ist
      <math|<around*|\||L<around*|(|G|)><rsup|v v>|\|>> gleich der Anzahl
      <math|t<around*|(|G|)>> der aufspannenden B�ume von <math|G>.

      <item*|Satz von Tutte>Ist <math|G> ein 3-fach zusammenh�ngender
      eingebetteter planarer Graph, dessen �u�ere Facette auf einem konvexen
      Polygon fixiert wird, dann ist das Schwerpunktlayout kreuzungsfrei und
      alle inneren Facetten sind konvex
    </description>

    <strong|Nachteil> von Schwerpunktlayout:

    <\itemize>
      <item>Exponentiell schlechte Aufl�sung (Verh�ltnis zwischen dem
      kleinsten und gr��ten Unterschied der Koordinaten je zweier Knoten)

      <item>Exponentiell schlechte Winkelaufl�sung

      <item>L�sen der LGS ist aufw�ndig (Gau�'sche Elimination in
      <math|O<around*|(|n<rsup|3>|)>>).

      Einsatz von N�herungsverfahren (z.B. Gau�-Seidel-Iteration f�r gro�e,
      d�nne Graphen: Ersetze in jedem Schritt den Wert einer Komponente des
      aktuellen L�sungsvektors durch die L�sung der zugeh�rigen Gleichung.
      <math|\<Rightarrow\>>Platziere jeweils einen Knoten aus
      <math|V\<setminus\>V<rsub|0>> in den Schwerpunkt der aktuellen
      Positionen seiner Nachbarn)
    </itemize>

    <item*|Spektrallayouts>Formulierung der Optimalit�tsbedingung als
    Eigengleichung der Laplace'schen Matrix

    <strong|Definition:> Sei <math|G=<around*|(|V,E|)>> ein zusammenh�ngender
    Graph und <math|L<around*|(|G|)>> seine Laplace-Matrix mit zugeh�rigen
    Eigenpaaren <math|<around*|(|\<lambda\><rsub|1>,v<rsub|1>|)>,\<ldots\>,<around*|(|\<lambda\><rsub|n>,v<rsub|n>|)>>,
    wobei <math|\<lambda\><rsub|i>\<leqslant\>\<lambda\><rsub|i+1>> und
    <math|v<rsub|i>\<perp\>v<rsub|i+1>> f�r alle <math|i>. Dann ist das
    (Laplace'sche) Spektrallayout von <math|G> definiert als:

    <\equation*>
      x\<assign\>v<rsub|2>\<nocomma\>,y\<assign\>v<rsub|3>
    </equation*>

    Berechnung mittels Standardverfahren oder mit Hilfe von
    <em|PowerIteration>

    <item*|Multidimensionale Skalierung>Zielfunktion entspricht
    physikalischem Modell des Graphen, bei dem alle Kanten als Federn mit
    Ideall�nge 0 repr�sentiert werden. Federn werden aber nicht nur zwischen
    adjazenten Knoten gespannt, sondern zwischen jedes Paar von Knoten. Die
    Ideall�nge der Federn wird so festgelegt, dass ein ideales Layout einen
    k�rzesten Weg zwischen den beiden Endknoten als gerade Strecke
    repr�sentiert.

    Nichtlineares Gleichungssystem, Finden eines lokalen Optimums durch
    schrittweises Verbessern (Gradientenverfahren).

    <item*|Globale Zielfunktionen und Simulated Annealing>Formulierung als
    allgemeines Optimierungsproblem und L�sen mithilfe von Verfahren wie
    <em|Simulated Annealing> (bekannt!)
  </description>

  <section|Kombinatorische Optimierung mittels Flussmethoden>

  Flussmethoden werden in diesem Abschnitt f�r drei Probleme eingesetzt:
  Knickminimierung in orthogonalen Layouts, aufw�rtsgerichtete Layouts von
  DAGs und Optimierung der Winkelaufl�sung in geradlinigen Layouts.

  <subsection|Grundlagen>

  <\description>
    <item*|Planarit�t>Ein Graph ist planar, falls er eine planare Einbettung
    besitzt. Eine solche Einbettung zerlegt die Ebene in Facetten.

    Eine <strong|kombinatorische Einbettung> ist eine Darstellung einer
    planaren Einbettung als Adjazenzlisten, in denen die Kanten gem�� der
    Einbettung zyklisch (z.B.<space|1spc>im Gegenuhrzeigersinn) abgelegt
    sind.

    Jeder planare Graph hat eine geradlinige planare Einbettung.

    <item*|Euler-Formel>F�r einen zusammenh�ngenden planaren Graphen erf�llt
    jede seiner Einbettungen die Formel

    <\equation*>
      <around*|\||V|\|>-<around*|\||E|\|>+f=2
    </equation*>

    wobei <math|f> die Anzahl der Facetten ist.

    <item*|Klassisches <math|s>-<math|t>-Flussmodell>Ein Flussnetzwerk
    besteht aus einem gerichteten Graphen mit Kantenkapazit�ten und
    ausgezeichneten Knoten <math|s> (Quelle) und <math|t> (Senke). (<math|s>
    und <math|t> d�rfen beide ein- und ausgehende Kanten haben!)

    Ein <em|Fluss> ist eine Abbildung von Kanten auf (Fluss-)Werte in
    <math|\<bbb-R\><rsub|0><rsup|+>>, die folgende Bedingungen erf�llt:

    <\description>
      <item*|Kapazit�t>Der Flusswert einer Kante muss <math|\<gtr\>0> sein
      und <math|\<leqslant\>> der Kantenkapazit�t sein

      <item*|Flusserhaltung>Die Summe der ein- und ausgehenden Fl�sse eines
      Knotens (au�er <math|s> und <math|t>) muss 0 sein.
    </description>

    Der <em|Wert> eines Flusses ist der �berschuss der Quelle bzw. das
    Defizit der Senke. Ziel ist es, einen Fluss mit maximalem Wert zu finden
    (Max-Flow-Problem).

    Der maximale Wert eines <math|s>-<math|t>-Flusses ist gleich der
    minimalen Kapazit�t eines <math|s>-<math|t>-Schnittes (Klassisches
    Dualit�tsresultat)

    <item*|Allgemeines Flussmodell>Es gibt keine Quelle und Senke mehr.
    Kanten haben untere und obere Kapazit�ten und es existiert eine
    Knotenbewertungsfunktion <math|b:V\<longrightarrow\>\<bbb-R\>>, sodass
    sich die Bewertungen aller Knoten zu 0 summieren.

    Knoten mit <math|b\<gtr\>0> hei�en Quellen, Knoten mit <math|b\<less\>0>
    hei�en Senken.

    <\description>
      <item*|Kapazit�t>Der Flusswert einer Kante muss innerhalb der
      Kapazit�ten liegen.

      <item*|Flusserhaltung>Die Summe der ein- und ausgehenden Fl�sse eines
      Knotens entspricht genau seiner Bewertung.
    </description>

    <em|Allgemeines Flussproblem>: Finde einen zul�ssigen Fluss

    <em|MinCostFlow>: Finde einen zul�ssigen Fluss mit minimalen Kosten
    bez�glich einer Kostenfunktion, die jeder Kante einen Kostenwert
    zuordnet. Die Kosten eines Flusses sind definiert als
    <math|cost<around*|(|X|)>=<big-around|\<sum\>|<rsub|<around*|(|i,j|)>\<in\>E>cost<around*|(|i,j|)>\<cdot\>X<around*|(|i,j|)>>>.

    MinCostFlow kann in <math|O<around*|(|n<rsup|3/2>|)>> gel�st werden.
  </description>

  <subsection|Knickminimierung in orthogonalen Layouts>

  Wir betrachten hier nat�rlich nur Graphen mit maximalem Knotengrad 4.

  <\description>
    <item*|Allgemeine Knickminimierung>Das Problem, ein knickminimales
    orthogonales Layout eines Graphen mit Maximalgrad 4 zu finden, ist
    <math|\<cal-N\>\<cal-P\>>-schwer.

    <item*|Knickminimierung mit fester Einbettung>L�sst sich effizient l�sen.
    Gegeben sind ein planarer Graph und seine kombinatorische Einbettung,
    gegeben durch die Facetten <math|\<cal-F\>> und die �u�ere Facette
    <math|f<rsub|0>\<in\>\<cal-F\>>.

    <item*|Ansatz>Topology (Finden einer kombinatorischen Einbettung) --
    Shape (Finden einer orthogonalen Beschreibung) -- Metrics
    (Fl�chenminimierung)

    <item*|Verfahren von Tamassia>Zweistufiges Verfahren:

    <\enumerate>
      <item>Berechne eine <em|orthogonale Beschreibung> mit minimaler
      Knickanzahl (mittels Flussmethoden)

      <item><em|Kompaktierung> der Beschreibung zu einem Layout (ebenfalls
      mittels Flussmethoden)
    </enumerate>

    <item*|Orthogonale Beschreibung>Besteht aus einer Folge von
    Facettenbeschreibungen. Eine Facette wird beschrieben durch die
    Auflistung ihrer Randkanten, die Knicke dieser Randkanten sowie die
    Knickwinkel an den Knoten.

    <item*|Flussnetzwerk f�r die orthogonale Beschreibung>Flusseinheiten
    entsprechen 90-Grad-Winkeln. Die Knoten sind die Knoten des Graphen sowie
    die Knoten des Dualgraphen, wobei Kanten wie folgt verlaufen:

    <\itemize>
      <item>Knoten-Facetten-Kante: wenn Knoten zu Facette inzident ist

      Diese Kanten haben Kosten 0 und Kapazit�tseinschr�nkung
      <math|<around*|[|1,4|]>>.

      <item>Facetten-Facetten-Kante: wenn Facetten benachbart sind (durch
      gemeinsame Kante)

      Diese Kanten haben Kosten 1 und Kapazit�tseinschr�nkung
      <math|<around*|[|0,\<infty\>|)>>. Eine Flusseinheit auf einer solchen
      Kante entspricht einem Knick auf der zugeh�rigen \RDualkante`` im
      Ausgangsgraphen, somit wird hierdurch die Knickanzahl minimiert.
    </itemize>

    <item*|Kompaktierung>Zur gegebenen orthogonalen Beschreibung soll ein
    orthogonales Layout gefunden werden, das diese Beschreibung realisiert.

    Wenn alle Facetten in der orthogonalen Beschreibung <em|Rechtecke> sind,
    kann sogar f�r das konstruierte Layout <em|minimale Gesamtkantenl�nge>
    und <em|minimale Fl�che> garantiert werden.

    (Falls alle Facetten Rechtecke sind, sind alle Knicke Ecken der �u�eren
    Facette. Au�erdem kann ein korrektes Layout konstruiert werden, wenn die
    gegen�berliegenden Seiten f�r alle Facetten die gleiche L�nge zugewiesen
    bekommen.)

    <item*|Flussnetzwerke f�r die Kompaktierung>F�r jede Richtung (horizontal
    und vertikal) ein Flussnetzwerk. Die Knoten sind die inneren Facetten
    sowie zwei Knoten <math|s> und <math|t> auf der �u�eren Facette und zwei
    Knoten sind miteinander verbunden, wenn die Facetten ein gemeinsames
    Kantensegment besitzen (spezielle Regelung f�r <math|s> und <math|t>,
    siehe Skript).

    Der Wert des MinCostFlows im horizontalen Netzwerk ist gleich der Breite,
    im vertikalen Netzwerk gleich der H�he des entsprechenden Layouts. Die
    Summe der Kosten von <math|x> in beiden Netzwerken entspricht der
    Gesamtkantenl�nge des Layouts

    <item*|Erweiterung auf den allgemeinen Fall>Verfeinerung des Graphen
    durch Hinzuf�gen von Knoten und Kanten, sodass ein Graph mit einer
    orthogonalen Beschreibung entsteht, in der alle Facetten Rechtecke sind.

    Dabei wird f�r jeden Knick in der orthogonalen Beschreibung ein
    Dummy-Knoten eingef�gt und die orthogonale Beschreibung entsprechend
    ver�ndert.

    Das Flussnetzwerk garantiert jetzt <em|nicht >mehr minimale
    Gesamtkantenl�nge und Fl�che! Das Problem, ob sich ein allgemeiner Graph
    auf ein Gitter mit gegebener Fl�che zeichnen l�sst, ist
    <math|\<cal-N\>\<cal-P\>>-schwer.

    <item*|Erweiterungsm�glichkeiten>

    <\description>
      <item*|Umgehung der Gradbeschr�nkung>Ersetzen von Knoten mit hohem Grad
      durch einen \RRing``

      <item*|Nicht-planare Graphen>Einbetten und Ersetzen von Kreuzungen
      druch Dummy-Knoten
    </description>
  </description>

  <subsection|Aufw�rtsgerichtete planare Layouts>

  <\description>
    <item*|Aufw�rtsplanarer Graph>Ein DAG hei�t aufw�rtsplanar, falls es eine
    planare Einbettung dieses Graphen gibt, bei dem alle Kanten aufw�rts
    gerichtet sind (d.h.<space|1spc>durch eine monoton steigende Kurve
    dargestellt sind).

    <item*|<math|s>-<math|t>-Graph>Ein DAG hei�t <math|s>-<math|t>-Graph,
    wenn er genau eine Quelle <math|s> (nur ausgehende Kanten) und genau eine
    Senke <math|t> (nur eingehende Kanten) besitzt sowie die Kante
    <math|<around*|(|s,t|)>> enth�lt.

    <item*|Test auf Aufw�rtsplanarit�t>Der Test, ob ein Graph eine
    aufw�rtsplanare Einbettung besitzt, ist
    <math|\<cal-N\>\<cal-P\>>-vollst�ndig.

    <item*|Charakterisierung aufw�rtsplanarer Graphen>F�r einen gerichteten
    Graphen <math|G> sind �quivalent:

    <\enumerate>
      <item><math|G> ist aufw�rtsplanar

      <item><math|G> hat ein geradliniges aufw�rtsplanares Layout

      <item><math|G> ist aufspannender Subgraph eines planaren
      <math|s>-<math|t>-Graphen, d.h.<space|1spc><math|G> kann durch
      Hinzuf�gen einer oder mehrerer Kanten zu einem planaren
      <math|s>-<math|t>-Graphen gemacht werden.
    </enumerate>

    <item*|Test auf Aufw�rtsplanarit�t mit vorgegebener Einbettung>Ist die
    (kombinatorische) Einbettung vorgegeben, dann kann in Polynomialzeit
    gepr�ft werden, ob es dazu ein aufw�rtsplanares Layout gibt.

    <item*|Bimodalit�t>Ein eingebetteter gerichteter Graph hei�t
    <em|bimodal>, falls jeder Knoten bimodal ist, d.h.<space|1spc>falls die
    Folge seiner inzidenten Kanten (bzgl.<space|1spc>Einbettung) sich in
    h�chstens zwei Teilfolgen aufteilen l�sst, sodass die eine Teilfolge nur
    aus eingehenden und die andere nur aus ausgehenden Kanten besteht.

    Bimodalit�t ist <em|notwendige Bedingung> f�r Aufw�rtsplanarit�t, aber
    nicht hinreichend. Hinreichende Bedingung ist Bimodalit�t + Existenz von
    konsistenter Facettenzuordnung <math|\<Phi\>>.

    <item*|Facettenzuordnung <math|\<Phi\>>>Gegeben: DAG mit kombinatorischer
    Einbettung, �u�ere Facette nicht festgelegt. Eine Abbildung
    <math|\<Phi\>>, die jeder Quelle und jeder Senke aus <math|V> eine
    Facette zuordnet, hei�t konsistent bez�glich <math|h\<in\>\<cal-F\>>,
    falls gilt:

    <\equation*>
      <around*|\||\<Phi\><rsup|-1><around*|(|f|)>|\|>=<choice|<tformat|<table|<row|<cell|A<around*|(|f|)>-1,>|<cell|f\<in\>\<cal-F\>\<setminus\><around*|{|h|}>>>|<row|<cell|A<around*|(|f|)>+1,>|<cell|f=h>>>>>
    </equation*>

    Dabei bezeichnet <math|A<around*|(|f|)>> die Anzahl der Winkel zwischen
    zwei eingehenden Kanten an <math|f> (gleich der Anzahl der Winkel
    zwischen zwei ausgehenden Kanten an <math|f>).

    <math|\<Phi\>> ist konsistent, falls sie bez�glich irgendeines
    <math|h\<in\>\<cal-F\>> konsistent ist.

    <item*|Test auf Aufw�rtsplanarit�t>Gegeben ein eingebetteter, bimodaler,
    planarer DAG. Es kann in <math|O<around*|(|<around*|\||V|\|>\<cdot\>r|)>>
    getestet werden, ob er aufw�rtsplanar ist (wobei <math|r> die Anzahl der
    Quellen und Senken in dem Graphen ist).

    Dazu wird ein Flussnetzwerk konstruiert, das aus den Quellen und Senken
    des Graphen sowie aus den Facetten besteht. Die Quellen und Senken des
    Graphen sind Quellen des Flussnetzwerks mit Bedarf 1, die Facetten sind
    Senken des Flussnetzwerks mit Bedarf <math|-<around*|(|A<around*|(|f|)>-1|)>>
    f�r <math|\<cal-F\>\<setminus\><around*|{|f<rsub|0>|}>> und
    <math|-<around*|(|A<around*|(|f<rsub|0>|)>|)>+1> f�r <math|f<rsub|0>>.
    Kanten verlaufen von Quellen-/Senken-Knoten zu adjazenten Facettenknoten.

    Das Netzwerk hat genau dann einen Fluss von Wert <math|r>, wenn eine
    konsistente Abbildung <math|\<Phi\>> existiert. Diese wird genau durch
    die Kanten des Flussnetzwerkes mit Flusswert 1 induziert.

    <item*|Konstruktion eines <math|s>-<math|t>-Graphen>Konstruiert werden
    soll ein <math|s>-<math|t>-Graph, der den gegebenen aufw�rtsplanaren
    Graphen als Subgraphen enth�lt, bei gegebener konsistenter Abbildung
    <math|\<Phi\>>.

    Idee: Verfeinern der Facetten, bis jede Facette nur noch zu zwei Winkeln
    adjazent ist.

    Laufzeit: <math|O<around*|(|n|)>>
  </description>

  <subsection|Winkelaufl�sung in geradlinigen Layouts>

  <\description>
    <item*|Gesuchtes>Gegeben sei ein planarer Graph. Finde eine geradlinige
    planare Einbettung, in welcher der minimal vorkommende Winkel maximal
    ist.

    Dieses Problem ist <math|\<cal-N\>\<cal-P\>>-schwer; wir beschr�nken uns
    daher auf die Variante mit vorgegebener Einbettung.

    <item*|Flussnetzwerk>Die Konstruktion ist �hnlich wie bei der
    Knickminimierung in orthogonalen Layouts. Die Flusseinheiten entsprechen
    beliebigen Winkeln. Die Knoten des Netzwerks sind die Knoten und Facetten
    des Eingabegraphen. Kanten verbinden zueinander adjazente Knoten und
    Facetten.

    Die Knoten des Graphen entsprechen den Quellen, jeweils mit Bedarf
    <math|2\<pi\>>. Die Facetten entsprechen den Senken, mit Bedarf
    <math|-<around*|(|d<rsub|G><around*|(|f|)>-2|)>*\<pi\>>, falls
    <math|f\<neq\>f<rsub|0>>, und <math|-<around*|(|d<rsub|G><around*|(|f|)>+2|)>*\<pi\>>
    sonst.

    <item*|Lokalkonsistenz <math|\<neq\>> realisierbares Layout>Ein g�ltiger
    Fluss im Netzwerk liefert eine lokal-konsistente Winkelzuweisung. Es gibt
    aber Graphen mit lokal-konsistenter Winkelzuweisung, f�r die kein Layout
    konstruiert werden kann.

    <item*|Planare Dreiecksgraphen>Ein planarer Dreiecksgraph ist ein Graph,
    dessen Facetten (bis auf die �u�ere Facette) Dreiecke sind.

    F�r einen planaren Dreiecksgraphen mit gegebener Winkelzuweisung gibt es
    genau dann eine geradlinige Einbettung mit dieser Winkelzuweisung, wenn

    <\enumerate>
      <item>f�r alle Knoten <math|v> die Summe der Flusswerte auf zu <math|v>
      inzidenten Knoten-Facetten-Kanten <math|2\<pi\>> betr�gt

      <item>f�r alle inneren Facetten <math|f> die Summe der Flusswerte auf
      zu <math|f> inzidenten Knoten-Facetten-Kanten <math|\<pi\>> betr�gt

      <item>f�r alle <math|v>, die nicht zu <math|f<rsub|0>> inzident sind,
      das Produkt der Winkelverh�ltnisse auf dem Rad um <math|v<rsub|>>
      gleich 1 ist

      <item>f�r alle <math|v>, die zu <math|f<rsub|0>> inzident sind, die
      Summe der Flusswerte auf zu <math|v> inzidenten Knoten-Facetten-Kanten
      (au�er zu <math|f<rsub|0>>) kleiner oder gleich <math|\<pi\>> ist.
    </enumerate>

    <item*|Untere Schranken f�r die Winkelaufl�sung>Eine untere Schranke f�r
    die Winkelaufl�sung erh�lt man mittels bin�rer Suche �ber die untere
    Schranke der Flusswerte im Flussnetzwerk.

    Da die Eigenschaft der Lokalkonsistenz notwendig f�r ein korrektes Layout
    ist, ist der dabei erhaltene minimale Winkel eine obere Schranke f�r die
    optimale Winkelaufl�sung.

    <strong|Satz:> In einem triangulierten planar eingebetteten Graph gibt es
    im zugeh�rigen Netzwerk einen Fluss, dessen minimaler Kantenwert
    <math|x<rsub|min>\<geqslant\><frac|\<pi\>|3\<cdot\><around*|(|d<rsub|max><around*|(|G|)>-1|)>>>
    ist (optimal w�re <math|<frac|2*\<pi\>|d<rsub|max><around*|(|G|)>>>).
  </description>

  <section|Lagenlayouts>

  <\description>
    <item*|Ziele bei Lagenlayouts>Gegeben ein gerichteter Graph:

    <\itemize>
      <item>Kanten sollen m�glichst aufw�rts gerichtet sein

      <item>Kreuzungen sollen minimiert werden

      <item>Kanten sollen m�glichst vertikal und m�glichst geradlinig sein

      <item>Knoten sollen gleichm��ig verteilt sein

      <item>Lange Kanten sollen vermieden werden
    </itemize>

    Diese Kriterien widersprechen einander zum Teil!

    <item*|Sugiyama-Framework>Die Methode von Sugiyama besteht aus vier
    Schritten:

    <\description>
      <item*|1. Entfernen von Zyklen>Finde eine minimale Anzahl zu
      entfernender Kanten (Minimum Feedback Arc Set) und drehe deren Richtung
      um

      <item*|2. Lagenzuordnung>Berechne eine Zuordnung der Knoten auf Lagen.
      F�ge Dummy-Knoten so ein, dass Kanten nur noch Knoten
      aufeinanderfolgender Lagen verbinden

      <item*|3. Kreuzungsreduktion>Reduziere die Anzahl der Kreuzungen
      zwischen Lagen

      <item*|4. Knoten-/Kantenpositionierung>Berechne die
      <math|x>-Koordinaten der Knoten so, dass keine �berlappungen entstehen.
      F�ge Kanten ein, entferne Dummy-Knoten und stelle urspr�ngliche
      Kantenrichtung wieder her.
    </description>

    <item*|1. Zyklenentfernung>Die folgenden Probleme sind �quivalent und
    <math|\<cal-N\>\<cal-P\>>-schwer:

    <\description>
      <item*|Maximal azyklischer Subgraph>Finde azyklischen aufspannenden
      Subgraph mit maximaler Kantenanzahl.

      <item*|Minimum Feedback Arc Set>Finde minimale Teilmenge der Kanten,
      sodass der Graph nach Entfernen dieser Kanten azyklisch ist.

      <item*|Lineare Anordnung>Finde eine Anordnung der Knoten so, dass
      m�glichst wenige Kanten in die \Rfalsche`` Richtung zeigen.
    </description>

    <item*|Greedy-Algoritmus f�r die Zyklenentfernung>Betrachte Knoten in
    beliebiger Reihenfolge. F�ge entweder eingehender oder ausgehende Kanten
    zu <math|A<rprime|'>> hinzu (je nachdem, welche der Mengen gr��er ist)
    und l�sche den Knoten.

    Der Graph mit der Kantenmenge <math|A<rprime|'>> ist zyklenfrei.

    Die Laufzeit ist in <math|O<around*|(|n+m|)>>, aber <math|A<rprime|'>>
    hat nur mindestens <math|<around*|\||A|\|>/2> viele Kanten.

    <item*|Besserer Greedy-Algorithmus>Greedy-Heuristik von Eades et al.
    Wiederhole, solange noch Knoten im Graphen vorhanden sind:

    <\enumerate>
      <item>F�ge alle eingehenden Knoten von Senken zu <math|A<rprime|'>>
      hinzu

      <item>Entferne alle isolierten Knoten

      <item>F�ge alle ausgehenden Kanten von Quellen zu <math|A<rprime|'>>
      hinzu

      <item>Wenn Knotenmenge nicht leer ist, f�ge Knoten mit maximalem
      �berschuss an ausgehenden Kanten hinzu.
    </enumerate>

    Die Laufzeit ist in <math|O<around*|(|n+m|)>> und <math|A<rprime|'>> hat
    mindestens <math|<around*|\||A|\|>/2+<around*|\||V|\|>/6> viele Kanten.

    <item*|Andere Methoden zur Zyklenentfernung>Randomisierte Methoden,
    Exakte Methode via Linear-Ordering Polytope + Cutting-Plane method

    <item*|2. Lagenzuordnung>Ein DAG sei gegeben. Finde Lagenzuordnung
    (d.h.<space|1spc>Partition der Knotenmenge in Lagen), sodass Kanten nur
    zu h�heren Lagen verlaufen

    <item*|Minimierung der H�he>Die H�henminimierung ohne weitere
    Einschr�nkungen ist leicht; man muss nur die <em|transitive Reduktion>
    des Graphen berechnen (\RAbk�rzungen`` zwischen zwei Knoten werden
    entfernt)

    <item*|Minimierung der H�he bei vorgegebener Breite>Dieses Problem ist
    �quivalent zu \RScheduling mit Vorg�ngerbedingungen``, das
    <math|\<cal-N\>\<cal-P\>>-vollst�ndig ist, selbst bei Jobs mit
    Einheitsdauern und 3 Maschinen (Reduktion von CLIQUE).

    Es ist au�erdem nicht approximierbar mit
    <math|\<cal-R\><rsub|\<cal-A\>>\<leqslant\><frac|4|3>>, selbst wenn alle
    Jobs Dauer 1 haben. Es gibt jedoch einen polynomialen
    Approximationsalgorithmus mit <math|\<cal-R\><rsub|A>\<leqslant\>2-<frac|1|B>>,
    wobei <math|B> die Anzahl der Maschinen ist. Dieser Algorithmus ist
    greedy und ordnet einer Maschine den ersten verf�gbaren Job zu, wenn
    diese frei ist.

    <item*|3. Kreuzungsminimierung>Betrachte eingeschr�nktes Problem
    <em|Zwei-Lagen-Kreuzungsminimierung> (Bipartite Crossing Number), das
    <math|\<cal-N\>\<cal-P\>>-schwer ist, selbst wenn die Knotenreihenfolge
    auf der zweiten Lage fest ist (Reduktion von Feedback Arc Set).

    <item*|Einseitige Kreuzungsminimierung>Diverse Heuristiken:

    <\description>
      <item*|Baryzenter-Heuristik><math|x>-Koordinate eines Knotens in Layer
      2 ist durchschnittliche <math|x>-Koordinate der Nachbarn in Layer 1

      Schnell, gute Ergebnisse; liefert kreuzungsfreie Layouts, falls
      m�glich; <math|O<around*|(|<sqrt|n>|)>>-Approximation

      <item*|Median-Heuristik>Genauso, aber mit Median der Nachbarn.

      Schnell; liefert kreuzungsfreie Layouts, falls m�glich;
      Faktor-3-Approximation

      <item*|Greedy-Switch>Vertausche iterativ jeweils benachbarte Knoten,
      falls dadurch weniger Kreuzungen entstehen.

      Laufzeit <math|O<around*|(|<around*|\||V<rsub|2>|\|>|)>> pro Iteration,
      maximal <math|<around*|\||V<rsub|2>|\|>> Iterationen
      <math|\<Rightarrow\>> Post-Processing f�r andere Heuristiken
    </description>

    sowie exakte Modellierung als ILP.
  </description>

  <section|Teile und herrsche>

  \RTeile und herrsche`` zerlegt ein Problem rekursiv in leicht zu l�sende
  Teilprobleme, die dann zusammengesetzt werden. Anwendungen sind hier
  Bin�rb�ume und serien-parallele Graphen.

  <subsection|Bin�rb�ume>

  <\description>
    <item*|Baum, Wurzelbaum, Bin�rbaum>Ein Baum ist ein zusammenh�ngender,
    azyklischer Graph. In einem Wurzelbaum ist ein Knoten als Wurzel
    ausgezeichnet. In einem Bin�rbaum hat jeder Knoten h�chstens zwei Kinder.

    <item*|Geradliniges Layout, Gitterlayout>Ein geradliniges Layout ist
    durch Angabe der Koordinaten der Knoten eindeutig bestimmt. Ein Layout
    mit ausschlie�lich ganzzahligen Koordinaten hei�t auch Gitterlayout.

    Wir fordern zus�tzlich ein kreuzungsfreies Aufw�rtslayout.

    <item*|Bin�rbaumlayout>Folgende Eigenschaften verlangen wir: geradlinig,
    tiefengeschichtet, kreuzungsfrei, Knoten derselben Tiefe haben Abstand
    <math|\<geqslant\>> 2, Knoten sind �ber ihren Nachfolgern zentriert,
    linke/rechte Nachfolger liegen strikt links/rechts von ihren Vorg�ngern,
    <em|identische Teilb�ume sind gleich ausgelegt.>

    <item*|Einfaches Gitterlayout>Durchl�uft man die Knoten eines Bin�rbaums
    in pre-, post- oder inorder-Reihenfolge
    <math|v<rsub|1>,\<ldots\>,v<rsub|n>>, so erh�lt man in Linearzeit ein
    kreuzungsfreies Gitterlayout durch

    <\equation*>
      x<around*|(|v<rsub|i>|)>\<assign\>i\<nocomma\>,y<around*|(|v<rsub|i>|)>=-tiefe<around*|(|v<rsub|i>|)>
    </equation*>

    Nachteile:

    <\enumerate>
      <item>Layouts haben immer die Breite <math|n-1>

      <math|\<Rightarrow\>> Breitenminimierung von Bin�rbaumlayouts ist
      <math|\<cal-N\>\<cal-P\>>-schwer! (Reduktion von 3SAT)

      <item>Kanten k�nnen L�nge <math|\<Theta\><around*|(|n|)>> haben

      Knoten sind i.A.<space|1spc>nicht �ber ihren Nachfolgern zentriert.

      <math|\<Rightarrow\>> Berechnung relativer statt absoluter Koordinaten
      sowie Bounding Boxes, dann Zentrieren des Knotens �ber seinen
      Nachfolgern. Immer noch in <math|O<around*|(|n|)>>, aber auch noch
      unn�tig breit.

      <math|\<Rightarrow\>> <strong|Algorithmus von Reingold und Tilford>:
      Ber�cksichtigt Konturen der Teilb�ume. Zwei Durchl�ufe des Baumes: in
      postorder (um Konturen und <math|x>-Offsets zu bestimmn), dann in
      preorder (um aus den <math|x>-Offsets durch Akkumulation
      <math|x>-Koordinaten zu bestimmen). Gesamtzeit in
      <math|O<around*|(|n|)>>.
    </enumerate>

    <item*|<math|h v>-Repr�sentation>Kanten zu Nachfolgern verlaufen immer
    entweder horizontal oder vertikal. Rechtslastiges <math|h v>-Layout
    (platziert gr��eren Teilbaum rechts, nicht einbettungserhaltend)
    garantiert Fl�chenschranke von <math|O<around*|(|n*log n|)>>, analog
    \Runtenlastiges`` Layout.

    <item*|Kreislayouts>Jeder Knoten des Bin�rbaumlayouts wird auf einen
    Kreis platziert, dessen Radius proportional zur Tiefe des Knotens ist.
    Der Anteil eines Teilbaums am Kreisumfang ist proportional zur Anzahl
    seiner Knoten.

    Allerdings muss der zur Verf�gung gestellte Kreisumfang beschr�nkt
    werden, um ein kreuzungsfreies Layout garantieren zu k�nnen.
  </description>

  <subsection|Serien-parallele Graphen>

  <\description>
    <item*|Definition>Ein gerichteter Graph hei�t serien-parallel, falls er
    aus einer gerichteten Kante besteht oder die serielle/parallele
    Komposition zweier serien-paralleler Graphen ist.

    Jeder serien-parallele Graph ist azyklisch und planar.

    Die Erkennung und Dekomposition (SPQR-Baum enth�lt keine R-Knoten)
    erfolgt in Linearzeit.

    <item*|Layouts haben exponentielle Fl�che>F�r allgemeine serien-parallele
    Graphen ben�tigt man im schlechtesten Fall ein Gitter der Gr��e
    <math|\<Omega\><around*|(|4<rsup|n>|)>>.

    F�r linkslastige serien-parallele Graphen (Q-Knoten kommen im
    Dekompositionsbaum nur als rechte Nachfolger von P-Knoten vor) kann
    mittels eines Teile-und-Herrsche-Algorithmus ein Layout der Gr��e
    <math|O<around*|(|n<rsup|2>|)>> erzeugt werden (Platzierung auf
    rechtwinkligem Dreieck).

    <item*|Sichtbarkeitsrepr�sentation>Serien-parallele Graphen lassen sich
    in Sichtbarkeitsrepr�sentationen visualisieren (einmaliger
    postorder-Durchlauf durch den Dekompositionsbaum).

    <item*|Automorphismen>Die in einem kreuzungsfreien Aufw�rtslayout durch
    Symmetrien darstellbare Untergruppe der Automorphismengruppe
    (<math|\<pi\><rsub|v>> vertikale Spiegelung, <math|\<pi\><rsub|h>>
    horizontale Spiegelung, <math|\<pi\><rsub|p>> Punktspiegelung, <math|id>
    Identit�t) eines serien-parallelen Graphen ist eine von:

    <\itemize>
      <item><math|<around*|{|id|}>>

      <item><math|<around*|{|id,\<pi\>|}>> mit
      <math|\<pi\>\<in\><around*|{|\<pi\><rsub|v>,\<pi\><rsub|h>,\<pi\><rsub|p>|}>>

      <item><with|mode|math|<around*|{|id\<nocomma\>,\<pi\><rsub|v>,\<pi\><rsub|h>,\<pi\><rsub|p>|}>>
    </itemize>

    <item*|Bestimmen eines symmetrischen Layouts>Umordnung eines
    serien-parallelen Graphen, sodass maximal viele vertikale Symmetrien
    seiner Teilgraphen realisiert werden k�nnen:

    Kanonisierung des Dekompositionsbaumes (durch Kontraktion maximaler
    zusammenh�ngender Mengen von S- bzw. P-Knoten), danach Zuweisung einer
    Kodierung sodass gilt: Zwei Komponenten derselben Tiefe haben dieselbe
    Kodierung <math|\<Leftrightarrow\>> Komponenten sind isomorph.
  </description>

  <section|Inkrementelle Konstruktion>

  Statt wie im vorherigen Kapitel immer gr��ere Teillayouts zusammenzusetzen,
  wird hier ein Ausgangslayout St�ck f�r St�ck erweitert.

  Dabei ist die Reihenfolge oftmals von gro�er Bedeutung.

  Der hier vorgestellte Algorithmus berechnet eine orthogonale Zeichnung.
  Dazu werden die zweifachen Zusammenhangskomponenten berechnet, iterativ
  layoutet und dann das Layout des Gesamtgraphen rekursiv berechnet.

  <\description>
    <item*|Berechnen von zweifachen Zusammenhangskomponenten>Algorithmus von
    Tarjan:

    <\enumerate>
      <item>Berechne Lowpoints

      Der Lowpoint <math|v> von <math|u> ist derjenige Knoten, der von allen
      Nachfolgern von <math|u> mit der gr��ten Tiefe im Tiefensuchbaum.

      <item>Benutzer Lowpoint-Information, um Zusammenhangsinformationen zu
      berechnen.

      Dabei hilfreich: Jeder Knoten <math|v>, der nicht die Wurzel ist, ist
      genau dann ein Separatorknoten, wenn ein Kindknoten <math|y> von
      <math|v> existiert, sodass <math|lowpoint<around*|(|y|)>\<geqslant\>
      tiefe<around*|(|v|)>>.
    </enumerate>

    <item*|Layout der zweifachen Zusammenhangskomponente>Benutze
    <strong|<math|s>-<math|t>-Ordnung>, d.h.<space|1spc>eine Knotenordnung
    <math|s:=v<rsub|1>,v<rsub|2>,\<ldots\>,v<rsub|n>=:t>, <math|s\<neq\>t>,
    sodass <math|s> die einzige Quelle und <math|t> die einzige Senke ist.
    Ist <math|G> ein zweifach zusammenh�ngender Graph dann existiert zu jeder
    Kante <math|<around*|(|s,t|)>> eine <math|s>-<math|t>-Ordnung.

    Eine <strong|<math|s>-<math|t>-Orientierung> (bipolar orientation) eines
    Graphen ist eine Kantenorientierung, sodass der resultierende Graph
    azyklisch ist und <math|s> die einzige Quelle sowie <math|t> die einzige
    Senke sind. Ein Graph hat eine <math|s>-<math|t>-Ordnung genau dann, wenn
    er eine <math|s>-<math|t>-Orientierung hat.

    Wir berechnen eine <math|s>-<math|t>-Orientierung aus einer
    <strong|Ohrenzerlegung>.

    Ein Ohr ist ein einfacher Pfad oder Kreis im Graphen. Ein Ohr hei�t
    offen, falls es kein Kreis ist. Eine (offene) Ohrenzerlegung ist eine
    Folge von (offenen) Ohren, sodass die Kantenmengen eine Partition der
    Kantenmenge des Graphen bilden und \<less\>TODO\<gtr\>

    <item*|Orthogonales Layout aus <math|s>-<math|t>-Ordnung>Mittels eines
    iterativen Verfahrens kann ein orthogonales Layout aus einer
    <math|s>-<math|t>-Ordnung gewonnen werden (beginnend mit der Quelle). Die
    ben�tigte Gittergr��e ist h�chstens <math|<around*|(|m-n+1|)>\<cdot\>n>.
    Insgesamt gibt es h�chstens <math|2*m-2*n+4> Knicke, und keine Kante hat
    mehr als zwei Knicke (es sei denn, <math|G> ist ein Oktaeder).

    <item*|Algorithmus f�r allgemeine Graphen>Ist <math|G> ein einfach
    zusammenh�ngender Graph mit Maximalgrad 4. Dann kann <math|G> auf einem
    Gitter der Gr��e <math|n\<cdot\>n> mit h�chstens 2 Knicken pro Kante
    eingebettet werden.

    <item*|Gitterlayouts f�r planare Graphen>
  </description>

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;

  \;
</body>

<\initial>
  <\collection>
    <associate|language|german>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-10|<tuple|6|?>>
    <associate|auto-11|<tuple|6.1|?>>
    <associate|auto-12|<tuple|6.2|?>>
    <associate|auto-13|<tuple|7|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|4|?>>
    <associate|auto-5|<tuple|4.1|?>>
    <associate|auto-6|<tuple|4.2|?>>
    <associate|auto-7|<tuple|4.3|?>>
    <associate|auto-8|<tuple|4.4|?>>
    <associate|auto-9|<tuple|5|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Einf�hrung>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Kr�ftebasierte
      Verfahren> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Globale
      und lokale Optimierung> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Kombinatorische
      Optimierung mittels Flussmethoden> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4><vspace|0.5fn>

      <with|par-left|<quote|1.5fn>|Grundlagen
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1.5fn>|Knickminimierung in orthogonalen Layouts
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1.5fn>|Aufw�rtsgerichtete planare Layouts
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1.5fn>|Winkelaufl�sung in geradlinigen Layouts
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Lagenlayouts>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Teile
      und herrsche> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10><vspace|0.5fn>

      <with|par-left|<quote|1.5fn>|Bin�rb�ume
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1.5fn>|Serien-parallele Graphen
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Inkrementelle
      Konstruktion> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>