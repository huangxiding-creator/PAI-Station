# Animation, Transition, and Media State (Cards D1 and D2)

Use these cards only when the user needs editable or playable state retained in PowerPoint. A static visual approximation belongs to a presentation-native or file-output route, not these cards.

## D1: animation and transition state

Ask what must survive: editable effect objects, sequence, timing, triggers, transition behavior, Morph relationships, slideshow playback, or only a static approximation.

## Execution gate

CU execution requires a current fixture and operation record for the installed OS and PowerPoint version. The fixture must include the exact effect classes required by the card and prove save/reopen/playback behavior. macOS and Windows remain separate.

Microsoft's current guidance establishes O2 test candidates for Animation Pane ordering, Add Animation, Start/Duration/Delay, object triggers, and media-bookmark triggers. It does not prove that the selected build exposes the same controls or that Manus can preserve effect identity. Qualify each required effect family separately.

Without that record, provide guidance or produce a static alternative. Do not claim that a missing feature in one runtime proves CU is the only possible implementation.

## D2: local media and playback state

Ask whether audio or video must be embedded or linked, which machine will play it, and whether poster frames, captions, trimming, autoplay, or portability must survive.

CU execution requires a licensed media fixture and an O1 operation record for the installed OS and PowerPoint version. The record must prove the selected packaging mode, save/reopen, playback, and delivery-machine portability. If that evidence is absent, prepare the media and a link or placement manifest, but do not claim that it was inserted or made portable in PowerPoint.

Microsoft's current format guidance establishes O2 input constraints and documents desktop insertion through the Audio or Video controls. Codec support differs by platform and changes over time; the O2 guide therefore defines fixture selection, not a generic insertion or portability promise.

## Safe workflow shape

1. duplicate the deck and inventory existing effects/media;
2. define the intended sequence, packaging, and playback behavior in plain language;
3. change one representative slide;
4. play it in slideshow mode and obtain user confirmation when timing or aesthetics are subjective;
5. apply the pattern to the remaining scope;
6. save, reopen, replay, and verify links or embedded assets on the delivery machine when portability matters.

PDF and static image exports do not retain animation. If the user needs the motion as a deliverable, offer a tested video or animation-step export route rather than implying a PDF will preserve it.
