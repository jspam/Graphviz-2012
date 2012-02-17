<TeXmacs|1.0.7.9>

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
    wenn er eine Quelle <math|s> (nur ausgehende Kanten) und eine Senke
    <math|t> (nur eingehende Kanten) besitzt sowie die Kante
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
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|3|?>>
    <associate|auto-4|<tuple|4|?>>
    <associate|auto-5|<tuple|4.1|?>>
    <associate|auto-6|<tuple|4.2|?>>
    <associate|auto-7|<tuple|4.3|?>>
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
    </associate>
  </collection>
</auxiliary>