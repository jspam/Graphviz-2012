<TeXmacs|1.0.7.9>

<style|generic>

<\body>
  <doc-data|<doc-title|Algorithmen zur Visualisierung von Graphen>>

  <section|Einführung>

  <\description>
    <item*|Informationsvisualisierung>(Graphenvisualisierung ist ein
    Spezialfall davon) Drei wesentliche Aspekte: <em|Informationsgehalt> der
    zu visualisierenden Daten, <em|Design> der Visualisierung,
    <em|Algorithmen> zur Realisierung des Designs

    <item*|Repräsentationen>Abbildungsvorschrift, die zu jedem Datenelement
    angibt, durch was für ein graphisches Element (Punkt, Linie, Fläche,
    Körper) es dargestellt wird.

    <\itemize-dot>
      <item>Standardrepräsentation: Knoten <math|\<rightarrow\>> Punkte,
      Kanten <math|\<rightarrow\>> Linien

      <item>Inklusionsrepräsentation: Knoten <math|\<rightarrow\>> Flächen,
      Kanten implizit

      <item>Berührungsrepräsentation: Knoten <math|\<rightarrow\>> Flächen,
      Kanten implizit

      <item>Intervallrepräsentation: Knoten <math|\<rightarrow\>> Linien,
      Kanten implizit

      <item>Sichtbarkeitsrepräsentation: Knoten <math|\<rightarrow\>> Linien.
      Kanten <math|\<rightarrow\>> Linien
    </itemize-dot>

    <item*|Beschreibung von Layouteigenschaften>Allgemein, da zu
    visualisierende Daten im Voraus nicht bekannt sind.

    <\description>
      <item*|Nebenbedingungen>Müssen auf jeden Fall erfüllt sein (z.B.
      Planarität)

      <item*|Gütekriterien>Müssen soweit wie möglich erfüllt sein (z.B.
      minimale Knickanzahl)
    </description>
  </description>

  <section|Kräftebasierte Verfahren>

  Benutzen physikalische Analogien zum Zeichnen von Graphen.

  <\description>
    <item*|Spring Embedder>Kanten verhalten sich ähnlich zu Federn:

    <\itemize>
      <item>Abstoÿende Kraft <math|f<rsub|rep>> zwischen nicht adjazenten
      Knoten, umgekehrt proportional zur Distanz

      <item>Anziehende Kraft <math|f<rsub|spring>> zwischen adjazenten
      Knoten, logarithmisch in der Distanz.
    </itemize>

    Ziel: Gleichgewichtszustand, in dem sich alle Kräfte eines Knotens zu
    Null summieren

    <math|\<rightarrow\>>Iterative Methoden

    <item*|Klassischer Spring Embedder>Berechne iterativ Verschiebevektor für
    jeden Knoten, bis alle Verschiebevektoren hinreichend klein sind oder
    eine festgelegte Anzahl an Iterationen durchlaufen wurde.

    <strong|Vorteile>: simpel, liefert für kleine/mittelgroÿe Graphen gute
    Ergebnisse

    <strong|Nachteile:> möglicherweise nicht stabil, Hängenbleiben in lokalem
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

      <item>Besuchen der Knoten in zufälliger Reihenfolge pro Iteration

      <item>Entdeckung von Oszillationen (durch Verkleinerung der
      Verschiebekonstanten, wenn Knoten in entgegengesetzter Richtung wie in
      der vorherigen Iteration bewegt wird) und Rotationen (\RDrehanzeiger``
      und Verringerung der Verschiebekonstanten)
    </itemize>

    <item*|Weitere Heuristiken zur Effizienzsteigerung>

    <\description>
      <item*|Grid-Technik>Ignorieren von weit entfernten Knoten (da diese
      nicht viel zur Verschiebung eines Knotens beitragen): Laufzeit bei
      gleichmäÿiger Verteilung in <math|O<around*|(|<around*|\||V|\|>+<around*|\||E|\|>|)>>
      pro Iteration.

      <item*|Verschiebefaktor anpassen>Gegen Ende (wenn Zustand fast stabil
      ist) wird der Verschiebefaktor verringert.

      <item*|Vorgegebenen Rahmen einhalten>Clipping eines Knotens, wenn er
      über diesen Rahmen hinaus verschoben würde.

      <item*|Wahl der idealen Federlänge <math|l>><math|l=c\<cdot\><sqrt|<frac|Flaeche|<around*|\||V|\|>>>>
      mit zu bestimmender Konstanten <math|c>
    </description>

    <item*|Laufzeitverbesserung>Berechnung der Kräfte zwischen Knotenpaaren
    <math|O<around*|(|n<rsup|2>|)>\<rightarrow\>O<around*|(|n*log n|)>>

    <\description>
      <item*|Quad-Tree-Datenstruktur>Knoten sind Blätter, Höhe
      <math|O<around*|(|log n|)>\<rightarrow\>>Aufbau in
      <math|O<around*|(|n*log n|)>>, Berechnung der abstoÿenden Kräfte eines
      Knotens in <math|O<around*|(|log n|)>>.

      <item*|Rekursive Berechnung im Quad-Tree>Approximieren von
      <math|f<rsub|rep>> anhand eines Güte-Parameters <math|\<gamma\>> und
      Schwerpunkt der Punkte in einer QT-Region

      Je kleiner <math|\<gamma\>>, desto besser die Approximation und desto
      höher die Laufzeit. Bei geeigneter Wahl von <math|\<gamma\>> ist die
      Laufzeit pro Knoten in <math|O<around*|(|h<rsub|QT>|)>>, also in
      <math|O<around*|(|log n|)>>.
    </description>

    <item*|Multilevel-Methoden für groÿe Graphen>Durch zufälliges
    Anfangslayout ergeben sich \RFaltungen``/\RÜberlappungen``, die nur durch
    viele Iterationen beseitigt werden können.

    <math|\<rightarrow\>> Rekursives Vergröbern des Graphen, Finden eines
    guten Layouts (schnell!), Expandieren des Layouts auf den
    Originalgraphen.

    <\description>
      <item*|Generelle Vorgehensweise>Konstruiere \RVergröberungen``
      <math|G<rsub|1>,G<rsub|2>,\<ldots\>,G<rsub|k>> von <math|G> mit
      abnehmender Knotenanzahl. Layout von <math|G<rsub|i-1>>: Setze Layout
      von <math|G<rsub|i>> als initiales Layout für ein kräftebasiertes
      Verfahren, positioniere restliche Knoten z.B. im Schwerpunkt ihrer
      Nachbarknoten (baryzentrisch), berechne Layout von <math|G<rsub|i-1>>.

      <item*|MIS-Vergröberung (GRIP)>Inklusionsmaximale Knotenmengen
      <math|V=V<rsub|0>\<supset\>\<ldots\>\<supset\>V<rsub|k>>, sodass jedes
      Knotenpaar in <math|V<rsub|i>> für <math|i\<gtr\>0> eine Mindestdistanz
      von <math|2<rsup|i-1>+1> in <math|G> hat.

      Logarithmische Länge, Aufbau von <math|V<rsub|i>> mittels BFS in
      <math|O<around*|(|<around*|\||V<rsub|i-1>|\|>|)>>

      <item*|Matching-Vergröberung>Rekursive Verkleinerung durch
      Verschmelzung der Endknoten von Matchingkanten zu einem Knoten
      <math|\<rightarrow\>> Reduktion pro Schritt auf die Hälfte (im
      Idealfall). Finden eines Matchings liegt in
      <math|O<around*|(|<around*|\||V|\|>+<around*|\||E|\|>|)>>.
    </description>
  </description>

  <section|Globale und lokale Optimierung>

  Ziel hier wie im vorherigen Kapitel: Weitflächige Verteilung der Knoten,
  ohne adjazente Knoten zu weit voneinander zu entfernen.

  <\description>
    <item*|Zielfunktion>Die Layouteigenschaften werden als Kriterien einer
    Zielfunktion behandelt, die mit allgemeinen Optimierungsmethoden
    behandelt werden kann.

    <item*|Zielfunktion für kurze Kanten><math|B<around*|(|p|)>=<big-around|\<sum\>|<rsub|<around*|{|u,v|}>\<in\>E>><around*|\<\|\|\>|p<around*|(|u|)>-p<around*|(|v|)>|\<\|\|\>><rsup|2>>,
    <math|p> Vektor der Knotenpositionen. Durch Ableiten (Ableitung 0 als
    notwendige Bedingung für ein lokales Minimum) ergibt sich die
    Formulierung mithilfe der <em|Laplace-Matrix>
    <math|L<around*|(|G|)>=D<around*|(|G|)>-A<around*|(|G|)>>, wobei
    <math|D<around*|(|G|)>> auf der Diagonalen die Knotengrade enthält und
    <math|A<around*|(|G|)>> die Adjazenzmatrix ist.

    <strong|Problem:> In optimalem Layout liegen alle Knoten einer
    Zusammenhangskomponenten auf einem Punkt <math|\<rightarrow\>> kein
    sinnvolles Layout. Daher sinnvolle Abwandlungen

    <item*|Schwerpunktlayouts>Fixieren der Position einer Teilmenge
    <math|V<rsub|0>\<subseteq\>V> von Knoten

    Falls <math|V<rsub|0>> aus jeder Zusammenhangskomponente von <math|G>
    mindestens einen Knoten enthält, gibt es genau ein optimales Layout, das
    durch Lösen eines LGS effizient bestimmt werden kann.

    Notation <math|L<around*|(|G|)><rsup|u v>>: Streichen der zu
    <math|u\<in\>V> gehörigen Zeile und zu <math|v> gehörigen Spalte.

    <\description>
      <item*|Matrix-Gerüst-Satz>Für jeden Multigraphen <math|G> und einen
      beliebigen Knoten <math|v> in <math|G> ist
      <math|<around*|\||L<around*|(|G|)><rsup|v v>|\|>> gleich der Anzahl
      <math|t<around*|(|G|)>> der aufspannenden Bäume von <math|G>.

      <item*|Satz von Tutte>Ist <math|G> ein 3-fach zusammenhängender
      eingebetteter planarer Graph, dessen äuÿere Facette auf einem konvexen
      Polygon fixiert wird, dann ist das Schwerpunktlayout kreuzungsfrei und
      alle inneren Facetten sind konvex
    </description>

    <strong|Nachteil> von Schwerpunktlayout:

    <\itemize>
      <item>Exponentiell schlechte Auflösung (Verhältnis zwischen dem
      kleinsten und gröÿten Unterschied der Koordinaten je zweier Knoten)

      <item>Exponentiell schlechte Winkelauflösung

      <item>Lösen der LGS ist aufwändig (Gauÿ'sche Elimination in
      <math|O<around*|(|n<rsup|3>|)>>).

      Einsatz von Näherungsverfahren (z.B. Gauÿ-Seidel-Iteration für groÿe,
      dünne Graphen: Ersetze in jedem Schritt den Wert einer Komponente des
      aktuellen Lösungsvektors durch die Lösung der zugehörigen Gleichung.
      <math|\<Rightarrow\>>Platziere jeweils einen Knoten aus
      <math|V\<setminus\>V<rsub|0>> in den Schwerpunkt der aktuellen
      Positionen seiner Nachbarn)
    </itemize>

    <item*|Spektrallayouts>Formulierung der Optimalitätsbedingung als
    Eigengleichung der Laplace'schen Matrix

    <strong|Definition:> Sei <math|G=<around*|(|V,E|)>> ein zusammenhängender
    Graph und <math|L<around*|(|G|)>> seine Laplace-Matrix mit zugehörigen
    Eigenpaaren <math|<around*|(|\<lambda\><rsub|1>,v<rsub|1>|)>,\<ldots\>,<around*|(|\<lambda\><rsub|n>,v<rsub|n>|)>>,
    wobei <math|\<lambda\><rsub|i>\<leqslant\>\<lambda\><rsub|i+1>> und
    <math|v<rsub|i>\<perp\>v<rsub|i+1>> für alle <math|i>. Dann ist das
    (Laplace'sche) Spektrallayout von <math|G> definiert als:

    <\equation*>
      x\<assign\>v<rsub|2>\<nocomma\>,y\<assign\>v<rsub|3>
    </equation*>

    Berechnung mittels Standardverfahren oder mit Hilfe von
    <em|PowerIteration>

    <item*|Multidimensionale Skalierung>Zielfunktion entspricht
    physikalischem Modell des Graphen, bei dem alle Kanten als Federn mit
    Ideallänge 0 repräsentiert werden. Federn werden aber nicht nur zwischen
    adjazenten Knoten gespannt, sondern zwischen jedes Paar von Knoten. Die
    Ideallänge der Federn wird so festgelegt, dass ein ideales Layout einen
    kürzesten Weg zwischen den beiden Endknoten als gerade Strecke
    repräsentiert.

    Nichtlineares Gleichungssystem, Finden eines lokalen Optimums durch
    schrittweises Verbessern (Gradientenverfahren).

    <item*|Globale Zielfunktionen und Simulated Annealing>Formulierung als
    allgemeines Optimierungsproblem und Lösen mithilfe von Verfahren wie
    <em|Simulated Annealing> (bekannt!)
  </description>

  <section|Kombinatorische Optimierung mittels Flussmethoden>

  Flussmethoden werden in diesem Abschnitt für drei Probleme eingesetzt:
  Knickminimierung in orthogonalen Layouts, aufwärtsgerichtete Layouts von
  DAGs und Optimierung der Winkelauflösung in geradlinigen Layouts.

  <subsection|Grundlagen>

  <\description>
    <item*|Planarität>Ein Graph ist planar, falls er eine planare Einbettung
    besitzt. Eine solche Einbettung zerlegt die Ebene in Facetten.

    Eine <strong|kombinatorische Einbettung> ist eine Darstellung einer
    planaren Einbettung als Adjazenzlisten, in denen die Kanten gemäÿ der
    Einbettung zyklisch (z.B.<space|1spc>im Gegenuhrzeigersinn) abgelegt
    sind.

    Jeder planare Graph hat eine geradlinige planare Einbettung.

    <item*|Euler-Formel>Für einen zusammenhängenden planaren Graphen erfüllt
    jede seiner Einbettungen die Formel

    <\equation*>
      <around*|\||V|\|>-<around*|\||E|\|>+f=2
    </equation*>

    wobei <math|f> die Anzahl der Facetten ist.

    <item*|Klassisches <math|s>-<math|t>-Flussmodell>Ein Flussnetzwerk
    besteht aus einem gerichteten Graphen mit Kantenkapazitäten und
    ausgezeichneten Knoten <math|s> (Quelle) und <math|t> (Senke). (<math|s>
    und <math|t> dürfen beide ein- und ausgehende Kanten haben!)

    Ein <em|Fluss> ist eine Abbildung von Kanten auf (Fluss-)Werte in
    <math|\<bbb-R\><rsub|0><rsup|+>>, die folgende Bedingungen erfüllt:

    <\description>
      <item*|Kapazität>Der Flusswert einer Kante muss <math|\<gtr\>0> sein
      und <math|\<leqslant\>> der Kantenkapazität sein

      <item*|Flusserhaltung>Die Summe der ein- und ausgehenden Flüsse eines
      Knotens (auÿer <math|s> und <math|t>) muss 0 sein.
    </description>

    Der <em|Wert> eines Flusses ist der Überschuss der Quelle bzw. das
    Defizit der Senke. Ziel ist es, einen Fluss mit maximalem Wert zu finden
    (Max-Flow-Problem).

    Der maximale Wert eines <math|s>-<math|t>-Flusses ist gleich der
    minimalen Kapazität eines <math|s>-<math|t>-Schnittes (Klassisches
    Dualitätsresultat)

    <item*|Allgemeines Flussmodell>Es gibt keine Quelle und Senke mehr.
    Kanten haben untere und obere Kapazitäten und es existiert eine
    Knotenbewertungsfunktion <math|b:V\<longrightarrow\>\<bbb-R\>>, sodass
    sich die Bewertungen aller Knoten zu 0 summieren.

    Knoten mit <math|b\<gtr\>0> heiÿen Quellen, Knoten mit <math|b\<less\>0>
    heiÿen Senken.

    <\description>
      <item*|Kapazität>Der Flusswert einer Kante muss innerhalb der
      Kapazitäten liegen.

      <item*|Flusserhaltung>Die Summe der ein- und ausgehenden Flüsse eines
      Knotens entspricht genau seiner Bewertung.
    </description>

    <em|Allgemeines Flussproblem>: Finde einen zulässigen Fluss

    <em|MinCostFlow>: Finde einen zulässigen Fluss mit minimalen Kosten
    bezüglich einer Kostenfunktion, die jeder Kante einen Kostenwert
    zuordnet. Die Kosten eines Flusses sind definiert als
    <math|cost<around*|(|X|)>=<big-around|\<sum\>|<rsub|<around*|(|i,j|)>\<in\>E>cost<around*|(|i,j|)>\<cdot\>X<around*|(|i,j|)>>>.

    MinCostFlow kann in <math|O<around*|(|n<rsup|3/2>|)>> gelöst werden.
  </description>

  <subsection|Knickminimierung in orthogonalen Layouts>

  Wir betrachten hier natürlich nur Graphen mit maximalem Knotengrad 4.

  <\description>
    <item*|Allgemeine Knickminimierung>Das Problem, ein knickminimales
    orthogonales Layout eines Graphen mit Maximalgrad 4 zu finden, ist
    <math|\<cal-N\>\<cal-P\>>-schwer.

    <item*|Knickminimierung mit fester Einbettung>Lässt sich effizient lösen.
    Gegeben sind ein planarer Graph und seine kombinatorische Einbettung,
    gegeben durch die Facetten <math|\<cal-F\>> und die äuÿere Facette
    <math|f<rsub|0>\<in\>\<cal-F\>>.

    <item*|Ansatz>Topology (Finden einer kombinatorischen Einbettung) --
    Shape (Finden einer orthogonalen Beschreibung) -- Metrics
    (Flächenminimierung)

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

    <item*|Flussnetzwerk für die orthogonale Beschreibung>Flusseinheiten
    entsprechen 90-Grad-Winkeln. Die Knoten sind die Knoten des Graphen sowie
    die Knoten des Dualgraphen, wobei Kanten wie folgt verlaufen:

    <\itemize>
      <item>Knoten-Facetten-Kante: wenn Knoten zu Facette inzident ist

      Diese Kanten haben Kosten 0 und Kapazitätseinschränkung
      <math|<around*|[|1,4|]>>.

      <item>Facetten-Facetten-Kante: wenn Facetten benachbart sind (durch
      gemeinsame Kante)

      Diese Kanten haben Kosten 1 und Kapazitätseinschränkung
      <math|<around*|[|0,\<infty\>|)>>. Eine Flusseinheit auf einer solchen
      Kante entspricht einem Knick auf der zugehörigen \RDualkante`` im
      Ausgangsgraphen, somit wird hierdurch die Knickanzahl minimiert.
    </itemize>

    <item*|Kompaktierung>Zur gegebenen orthogonalen Beschreibung soll ein
    orthogonales Layout gefunden werden, das diese Beschreibung realisiert.

    Wenn alle Facetten in der orthogonalen Beschreibung <em|Rechtecke> sind,
    kann sogar für das konstruierte Layout <em|minimale Gesamtkantenlänge>
    und <em|minimale Fläche> garantiert werden.

    (Falls alle Facetten Rechtecke sind, sind alle Knicke Ecken der äuÿeren
    Facette. Auÿerdem kann ein korrektes Layout konstruiert werden, wenn die
    gegenüberliegenden Seiten für alle Facetten die gleiche Länge zugewiesen
    bekommen.)

    <item*|Flussnetzwerke für die Kompaktierung>Für jede Richtung (horizontal
    und vertikal) ein Flussnetzwerk. Die Knoten sind die inneren Facetten
    sowie zwei Knoten <math|s> und <math|t> auf der äuÿeren Facette und zwei
    Knoten sind miteinander verbunden, wenn die Facetten ein gemeinsames
    Kantensegment besitzen (spezielle Regelung für <math|s> und <math|t>,
    siehe Skript).

    Der Wert des MinCostFlows im horizontalen Netzwerk ist gleich der Breite,
    im vertikalen Netzwerk gleich der Höhe des entsprechenden Layouts. Die
    Summe der Kosten von <math|x> in beiden Netzwerken entspricht der
    Gesamtkantenlänge des Layouts

    <item*|Erweiterung auf den allgemeinen Fall>Verfeinerung des Graphen
    durch Hinzufügen von Knoten und Kanten, sodass ein Graph mit einer
    orthogonalen Beschreibung entsteht, in der alle Facetten Rechtecke sind.

    Dabei wird für jeden Knick in der orthogonalen Beschreibung ein
    Dummy-Knoten eingefügt und die orthogonale Beschreibung entsprechend
    verändert.

    Das Flussnetzwerk garantiert jetzt <em|nicht >mehr minimale
    Gesamtkantenlänge und Fläche! Das Problem, ob sich ein allgemeiner Graph
    auf ein Gitter mit gegebener Fläche zeichnen lässt, ist
    <math|\<cal-N\>\<cal-P\>>-schwer.

    <item*|Erweiterungsmöglichkeiten>

    <\description>
      <item*|Umgehung der Gradbeschränkung>Ersetzen von Knoten mit hohem Grad
      durch einen \RRing``

      <item*|Nicht-planare Graphen>Einbetten und Ersetzen von Kreuzungen
      druch Dummy-Knoten
    </description>
  </description>

  <subsection|Aufwärtsgerichtete planare Layouts>

  <\description>
    <item*|Aufwärtsplanarer Graph>Ein DAG heiÿt aufwärtsplanar, falls es eine
    planare Einbettung dieses Graphen gibt, bei dem alle Kanten aufwärts
    gerichtet sind (d.h.<space|1spc>durch eine monoton steigende Kurve
    dargestellt sind).

    <item*|<math|s>-<math|t>-Graph>Ein DAG heiÿt <math|s>-<math|t>-Graph,
    wenn er genau eine Quelle <math|s> (nur ausgehende Kanten) und genau eine
    Senke <math|t> (nur eingehende Kanten) besitzt sowie die Kante
    <math|<around*|(|s,t|)>> enthält.

    <item*|Test auf Aufwärtsplanarität>Der Test, ob ein Graph eine
    aufwärtsplanare Einbettung besitzt, ist
    <math|\<cal-N\>\<cal-P\>>-vollständig.

    <item*|Charakterisierung aufwärtsplanarer Graphen>Für einen gerichteten
    Graphen <math|G> sind äquivalent:

    <\enumerate>
      <item><math|G> ist aufwärtsplanar

      <item><math|G> hat ein geradliniges aufwärtsplanares Layout

      <item><math|G> ist aufspannender Subgraph eines planaren
      <math|s>-<math|t>-Graphen, d.h.<space|1spc><math|G> kann durch
      Hinzufügen einer oder mehrerer Kanten zu einem planaren
      <math|s>-<math|t>-Graphen gemacht werden.
    </enumerate>

    <item*|Test auf Aufwärtsplanarität mit vorgegebener Einbettung>Ist die
    (kombinatorische) Einbettung vorgegeben, dann kann in Polynomialzeit
    geprüft werden, ob es dazu ein aufwärtsplanares Layout gibt.

    <item*|Bimodalität>Ein eingebetteter gerichteter Graph heiÿt
    <em|bimodal>, falls jeder Knoten bimodal ist, d.h.<space|1spc>falls die
    Folge seiner inzidenten Kanten (bzgl.<space|1spc>Einbettung) sich in
    höchstens zwei Teilfolgen aufteilen lässt, sodass die eine Teilfolge nur
    aus eingehenden und die andere nur aus ausgehenden Kanten besteht.

    Bimodalität ist <em|notwendige Bedingung> für Aufwärtsplanarität, aber
    nicht hinreichend. Hinreichende Bedingung ist Bimodalität + Existenz von
    konsistenter Facettenzuordnung <math|\<Phi\>>.

    <item*|Facettenzuordnung <math|\<Phi\>>>Gegeben: DAG mit kombinatorischer
    Einbettung, äuÿere Facette nicht festgelegt. Eine Abbildung
    <math|\<Phi\>>, die jeder Quelle und jeder Senke aus <math|V> eine
    Facette zuordnet, heiÿt konsistent bezüglich <math|h\<in\>\<cal-F\>>,
    falls gilt:

    <\equation*>
      <around*|\||\<Phi\><rsup|-1><around*|(|f|)>|\|>=<choice|<tformat|<table|<row|<cell|A<around*|(|f|)>-1,>|<cell|f\<in\>\<cal-F\>\<setminus\><around*|{|h|}>>>|<row|<cell|A<around*|(|f|)>+1,>|<cell|f=h>>>>>
    </equation*>

    Dabei bezeichnet <math|A<around*|(|f|)>> die Anzahl der Winkel zwischen
    zwei eingehenden Kanten an <math|f> (gleich der Anzahl der Winkel
    zwischen zwei ausgehenden Kanten an <math|f>).

    <math|\<Phi\>> ist konsistent, falls sie bezüglich irgendeines
    <math|h\<in\>\<cal-F\>> konsistent ist.

    <item*|Test auf Aufwärtsplanarität>Gegeben ein eingebetteter, bimodaler,
    planarer DAG. Es kann in <math|O<around*|(|<around*|\||V|\|>\<cdot\>r|)>>
    getestet werden, ob er aufwärtsplanar ist (wobei <math|r> die Anzahl der
    Quellen und Senken in dem Graphen ist).

    Dazu wird ein Flussnetzwerk konstruiert, das aus den Quellen und Senken
    des Graphen sowie aus den Facetten besteht. Die Quellen und Senken des
    Graphen sind Quellen des Flussnetzwerks mit Bedarf 1, die Facetten sind
    Senken des Flussnetzwerks mit Bedarf <math|-<around*|(|A<around*|(|f|)>-1|)>>
    für <math|\<cal-F\>\<setminus\><around*|{|f<rsub|0>|}>> und
    <math|-<around*|(|A<around*|(|f<rsub|0>|)>|)>+1> für <math|f<rsub|0>>.
    Kanten verlaufen von Quellen-/Senken-Knoten zu adjazenten Facettenknoten.

    Das Netzwerk hat genau dann einen Fluss von Wert <math|r>, wenn eine
    konsistente Abbildung <math|\<Phi\>> existiert. Diese wird genau durch
    die Kanten des Flussnetzwerkes mit Flusswert 1 induziert.

    <item*|Konstruktion eines <math|s>-<math|t>-Graphen>Konstruiert werden
    soll ein <math|s>-<math|t>-Graph, der den gegebenen aufwärtsplanaren
    Graphen als Subgraphen enthält, bei gegebener konsistenter Abbildung
    <math|\<Phi\>>.

    Idee: Verfeinern der Facetten, bis jede Facette nur noch zu zwei Winkeln
    adjazent ist.

    Laufzeit: <math|O<around*|(|n|)>>
  </description>

  <subsection|Winkelauflösung in geradlinigen Layouts>

  <\description>
    <item*|Gesuchtes>Gegeben sei ein planarer Graph. Finde eine geradlinige
    planare Einbettung, in welcher der minimal vorkommende Winkel maximal
    ist.

    Dieses Problem ist <math|\<cal-N\>\<cal-P\>>-schwer; wir beschränken uns
    daher auf die Variante mit vorgegebener Einbettung.

    <item*|Flussnetzwerk>Die Konstruktion ist ähnlich wie bei der
    Knickminimierung in orthogonalen Layouts. Die Flusseinheiten entsprechen
    beliebigen Winkeln. Die Knoten des Netzwerks sind die Knoten und Facetten
    des Eingabegraphen. Kanten verbinden zueinander adjazente Knoten und
    Facetten.

    Die Knoten des Graphen entsprechen den Quellen, jeweils mit Bedarf
    <math|2\<pi\>>. Die Facetten entsprechen den Senken, mit Bedarf
    <math|-<around*|(|d<rsub|G><around*|(|f|)>-2|)>*\<pi\>>, falls
    <math|f\<neq\>f<rsub|0>>, und <math|-<around*|(|d<rsub|G><around*|(|f|)>+2|)>*\<pi\>>
    sonst.

    <item*|Lokalkonsistenz <math|\<neq\>> realisierbares Layout>Ein gültiger
    Fluss im Netzwerk liefert eine lokal-konsistente Winkelzuweisung. Es gibt
    aber Graphen mit lokal-konsistenter Winkelzuweisung, für die kein Layout
    konstruiert werden kann.

    <item*|Planare Dreiecksgraphen>Ein planarer Dreiecksgraph ist ein Graph,
    dessen Facetten (bis auf die äuÿere Facette) Dreiecke sind.

    Für einen planaren Dreiecksgraphen mit gegebener Winkelzuweisung gibt es
    genau dann eine geradlinige Einbettung mit dieser Winkelzuweisung, wenn

    <\enumerate>
      <item>für alle Knoten <math|v> die Summe der Flusswerte auf zu <math|v>
      inzidenten Knoten-Facetten-Kanten <math|2\<pi\>> beträgt

      <item>für alle inneren Facetten <math|f> die Summe der Flusswerte auf
      zu <math|f> inzidenten Knoten-Facetten-Kanten <math|\<pi\>> beträgt

      <item>für alle <math|v>, die nicht zu <math|f<rsub|0>> inzident sind,
      das Produkt der Winkelverhältnisse auf dem Rad um <math|v<rsub|>>
      gleich 1 ist

      <item>für alle <math|v>, die zu <math|f<rsub|0>> inzident sind, die
      Summe der Flusswerte auf zu <math|v> inzidenten Knoten-Facetten-Kanten
      (auÿer zu <math|f<rsub|0>>) kleiner oder gleich <math|\<pi\>> ist.
    </enumerate>

    <item*|Untere Schranken für die Winkelauflösung>Eine untere Schranke für
    die Winkelauflösung erhält man mittels binärer Suche über die untere
    Schranke der Flusswerte im Flussnetzwerk.

    Da die Eigenschaft der Lokalkonsistenz notwendig für ein korrektes Layout
    ist, ist der dabei erhaltene minimale Winkel eine obere Schranke für die
    optimale Winkelauflösung.

    <strong|Satz:> In einem triangulierten planar eingebetteten Graph gibt es
    im zugehörigen Netzwerk einen Fluss, dessen minimaler Kantenwert
    <math|x<rsub|min>\<geqslant\><frac|\<pi\>|3\<cdot\><around*|(|d<rsub|max><around*|(|G|)>-1|)>>>
    ist (optimal wäre <math|<frac|2*\<pi\>|d<rsub|max><around*|(|G|)>>>).
  </description>

  <section|Lagenlayouts>

  <\description>
    <item*|Ziele bei Lagenlayouts>Gegeben ein gerichteter Graph:

    <\itemize>
      <item>Kanten sollen möglichst aufwärts gerichtet sein

      <item>Kreuzungen sollen minimiert werden

      <item>Kanten sollen möglichst vertikal und möglichst geradlinig sein

      <item>Knoten sollen gleichmäÿig verteilt sein

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
      Füge Dummy-Knoten so ein, dass Kanten nur noch Knoten
      aufeinanderfolgender Lagen verbinden

      <item*|3. Kreuzungsreduktion>Reduziere die Anzahl der Kreuzungen
      zwischen Lagen

      <item*|4. Knoten-/Kantenpositionierung>Berechne die
      <math|x>-Koordinaten der Knoten so, dass keine Überlappungen entstehen.
      Füge Kanten ein, entferne Dummy-Knoten und stelle ursprüngliche
      Kantenrichtung wieder her.
    </description>

    <item*|1. Zyklenentfernung>Die folgenden Probleme sind äquivalent und
    <math|\<cal-N\>\<cal-P\>>-schwer:

    <\description>
      <item*|Maximal azyklischer Subgraph>Finde azyklischen aufspannenden
      Subgraph mit maximaler Kantenanzahl.

      <item*|Minimum Feedback Arc Set>Finde minimale Teilmenge der Kanten,
      sodass der Graph nach Entfernen dieser Kanten azyklisch ist.

      <item*|Lineare Anordnung>Finde eine Anordnung der Knoten so, dass
      möglichst wenige Kanten in die \Rfalsche`` Richtung zeigen.
    </description>

    <item*|Greedy-Algoritmus für die Zyklenentfernung>Betrachte Knoten in
    beliebiger Reihenfolge. Füge entweder eingehender oder ausgehende Kanten
    zu <math|A<rprime|'>> hinzu (je nachdem, welche der Mengen gröÿer ist)
    und lösche den Knoten.

    Der Graph mit der Kantenmenge <math|A<rprime|'>> ist zyklenfrei.

    Die Laufzeit ist in <math|O<around*|(|n+m|)>>, aber <math|A<rprime|'>>
    hat nur mindestens <math|<around*|\||A|\|>/2> viele Kanten.

    <item*|Besserer Greedy-Algorithmus>Greedy-Heuristik von Eades et al.
    Wiederhole, solange noch Knoten im Graphen vorhanden sind:

    <\enumerate>
      <item>Füge alle eingehenden Knoten von Senken zu <math|A<rprime|'>>
      hinzu

      <item>Entferne alle isolierten Knoten

      <item>Füge alle ausgehenden Kanten von Quellen zu <math|A<rprime|'>>
      hinzu

      <item>Wenn Knotenmenge nicht leer ist, füge Knoten mit maximalem
      Überschuss an ausgehenden Kanten hinzu.
    </enumerate>

    Die Laufzeit ist in <math|O<around*|(|n+m|)>> und <math|A<rprime|'>> hat
    mindestens <math|<around*|\||A|\|>/2+<around*|\||V|\|>/6> viele Kanten.

    <item*|Andere Methoden zur Zyklenentfernung>Randomisierte Methoden,
    Exakte Methode via Linear-Ordering Polytope + Cutting-Plane method

    <item*|2. Lagenzuordnung>Ein DAG sei gegeben. Finde Lagenzuordnung
    (d.h.<space|1spc>Partition der Knotenmenge in Lagen), sodass Kanten nur
    zu höheren Lagen verlaufen

    <item*|Minimierung der Höhe>Die Höhenminimierung ohne weitere
    Einschränkungen ist leicht; man muss nur die <em|transitive Reduktion>
    des Graphen berechnen (\RAbkürzungen`` zwischen zwei Knoten werden
    entfernt)

    <item*|Minimierung der Höhe bei vorgegebener Breite>Dieses Problem ist
    äquivalent zu \RScheduling mit Vorgängerbedingungen``, das
    <math|\<cal-N\>\<cal-P\>>-vollständig ist, selbst bei Jobs mit
    Einheitsdauern und 3 Maschinen (Reduktion von CLIQUE).

    Es ist auÿerdem nicht approximierbar mit
    <math|\<cal-R\><rsub|\<cal-A\>>\<leqslant\><frac|4|3>>, selbst wenn alle
    Jobs Dauer 1 haben. Es gibt jedoch einen polynomialen
    Approximationsalgorithmus mit <math|\<cal-R\><rsub|A>\<leqslant\>2-<frac|1|B>>,
    wobei <math|B> die Anzahl der Maschinen ist. Dieser Algorithmus ist
    greedy und ordnet einer Maschine den ersten verfügbaren Job zu, wenn
    diese frei ist.

    <item*|3. Kreuzungsminimierung>Betrachte eingeschränktes Problem
    <em|Zwei-Lagen-Kreuzungsminimierung> (Bipartite Crossing Number), das
    <math|\<cal-N\>\<cal-P\>>-schwer ist, selbst wenn die Knotenreihenfolge
    auf der zweiten Lage fest ist (Reduktion von Feedback Arc Set).

    <item*|Einseitige Kreuzungsminimierung>Diverse Heuristiken:

    <\description>
      <item*|Baryzenter-Heuristik><math|x>-Koordinate eines Knotens in Layer
      2 ist durchschnittliche <math|x>-Koordinate der Nachbarn in Layer 1

      Schnell, gute Ergebnisse; liefert kreuzungsfreie Layouts, falls
      möglich; <math|O<around*|(|<sqrt|n>|)>>-Approximation

      <item*|Median-Heuristik>Genauso, aber mit Median der Nachbarn.

      Schnell; liefert kreuzungsfreie Layouts, falls möglich;
      Faktor-3-Approximation

      <item*|Greedy-Switch>Vertausche iterativ jeweils benachbarte Knoten,
      falls dadurch weniger Kreuzungen entstehen.

      Laufzeit <math|O<around*|(|<around*|\||V<rsub|2>|\|>|)>> pro Iteration,
      maximal <math|<around*|\||V<rsub|2>|\|>> Iterationen
      <math|\<Rightarrow\>> Post-Processing für andere Heuristiken
    </description>

    sowie exakte Modellierung als ILP.
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
    <associate|auto-10|<tuple|6|?>>
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
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Einführung>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Kräftebasierte
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

      <with|par-left|<quote|1.5fn>|Aufwärtsgerichtete planare Layouts
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1.5fn>|Winkelauflösung in geradlinigen Layouts
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Lagenlayouts>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>