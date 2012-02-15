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
    </associate>
  </collection>
</auxiliary>