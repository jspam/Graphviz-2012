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
    </description>
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
  </collection>
</references>