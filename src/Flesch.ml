module Mode =
  struct
    type t = Major | Minor
    let all = [Major; Minor]
    let show x = match x with
      | Major -> "major"
      | Minor -> "minor"
  end

module ArpeggioType =
  struct
    type t = TonicArpeggio of Mode.t
           | DominantArpeggio of Mode.t
           | Diminished
           | Dominant7

    let all = List.concat [List.map (fun x -> TonicArpeggio x) Mode.all;
                           List.map (fun x -> DominantArpeggio x) Mode.all;
                           [Diminished;Dominant7]]

    let show x = match x with
      | TonicArpeggio m -> Mode.show m ^ " tonic"
      | DominantArpeggio m -> (Mode.show m) ^ " dominant"
      | Diminished -> "diminished"
      | Dominant7 -> "dominant 7"
  end


module ChordType =
  struct
    type t = Thirds
           | Sixths
           | Octaves

    let all = [Thirds; Sixths; Octaves]

    let show x = match x with
      | Thirds -> "thirds"
      | Sixths -> "sixths"
      | Octaves -> "octaves"
  end

module ScaleType =
  struct
    type t = Melodic
           | InThirds
           | Chromatic

    let all = [Melodic;InThirds;Chromatic]

    let show x = match x with
      | Melodic -> ""
      | InThirds -> "melodic thirds"
      | Chromatic -> "chromatic"
  end

module ScaleArpeggio =
  struct
    type t = Scale of ScaleType.t
           | Arpeggio of ArpeggioType.t

    let all = List.concat [List.map (fun x -> Scale x) ScaleType.all;
                           List.map (fun x -> Arpeggio x) ArpeggioType.all]

    let show x = match x with
      | Scale st -> ScaleType.show st ^ " scale"
      | Arpeggio st -> ArpeggioType.show st ^ " arpeggio"
  end

module ViolinString =
  struct
    type t = IV | III | II | I

    let all = [IV; III; II; I]

    let show x = match x with
      | IV -> "IV"
      | III -> "III"
      | II -> "II"
      | I -> "I"
  end


let cross xs ys = List.flatten (List.map (fun x -> List.map (fun y -> (x,y)) ys) xs)

module FleschSection =
  struct
    type t = SingleOctave of ScaleArpeggio.t * ViolinString.t
           | ThreeOctave of ScaleArpeggio.t
           | ChordScale of ScaleType.t * ChordType.t

    let all = List.concat [List.map (fun (x,y) -> SingleOctave (x,y)) (cross ScaleArpeggio.all ViolinString.all);
                           List.map (fun x -> ThreeOctave x) ScaleArpeggio.all;
                           List.map (fun (x,y) -> ChordScale (x,y)) (cross ScaleType.all ChordType.all)]

    let show x = match x with
      | SingleOctave (sa,s) -> "single octave " ^ (ScaleArpeggio.show sa) ^ " on " ^ (ViolinString.show s)
      | ThreeOctave sa -> "three octave " ^ (ScaleArpeggio.show sa)
      | ChordScale (sa,s) -> (ScaleType.show sa) ^ " scale in " ^ (ChordType.show s)
  end

let uniformChoice xs = List.nth xs (Random.int (List.length xs))

let randomSection () = uniformChoice FleschSection.all
