---
name: trip
description: Search Trip.com through the trip MCP tools and present the results as compact deal cards. Use search_flights for cheap flights and fare calendars on a route, search_hotels for hotel recommendations with stay, price, property, room, payment, meal, rating, distance or sort preferences, and search_attractions for attraction tickets, day tours and local experiences, and travel services such as airport transfers, pocket Wi-Fi and SIM cards. Do not use for trains, car rentals, cruises or visas. The tools only search; booking and payment happen on the linked Trip.com page.
---

# Trip.com deals

Bundled references live beside the installed Trip `SKILL.md`, on the same computer. In the Ubuntu sandbox installation at `/home/ubuntu/.manus-addons/skills/current/trip/SKILL.md`, use the absolute paths below. If the session's skill catalog supplies a different Trip `SKILL.md` path (for example, under `.manus/addons/skills/current/` on a device), replace its final `SKILL.md` with `references/flights-checkout.md` or `references/hotels-checkout.md` and read that resulting absolute path on that computer. Do not use the ordinary official-skill directory `/home/ubuntu/.manus/skills/trip`, resolve references against the working directory, or open them as web links.

The `trip` MCP server searches Trip.com and returns normalized results. This skill owns routing, parameter collection and presentation; the tools own retrieval, validation and normalization. Results come with partner tracking already applied to every link.

This skill owns Trip search defaults, parameters, result display and checkout. When a scenario skill routes a booking here, use this workflow; do not delegate checkout back to the scenario skill.

| User intent | Tool | Key arguments |
|---|---|---|
| Flights, fares, cheap tickets on a route | `search_flights` | `departCityCode`, `startDate`, optional `arrivalCityCode` |
| Hotels and other stays | `search_hotels` | `cityName`, country, `latitude`, `longitude` |
| Attraction tickets | `search_attractions` | `productType: "ticket"`, `cityName` |
| Day tours, local experiences | `search_attractions` | `productType: "play_experience"`, `cityName` |
| Airport transfers, pickup, pocket Wi-Fi, SIM cards | `search_attractions` | `productType: "play_travel_tool"`, `cityName`; pass `excludeSim: false` when the user wants SIM cards |
| Show the chosen results as Trip.com cards | `show_results` | `requestIds` of the searches to show (see Result cards) |

The tools only search: they book nothing and take no payment or personal details. When the user only wants options, stop at the results. For a booking request, continue only after the user has chosen a result; otherwise show the cards and wait for their pick. Never book a mock result.

## Continue to checkout

- For flights, read `/home/ubuntu/.manus-addons/skills/current/trip/references/flights-checkout.md`; for stays, read `/home/ubuntu/.manus-addons/skills/current/trip/references/hotels-checkout.md`. These references are bundled with this skill. Read only the reference for the current product when continuing to checkout, not before searching.
- If a chosen Trip.com booking page is already open or supplied, continue from that page without repeating the addon search. Otherwise open the chosen result's booking link unchanged, including its query parameters. New searches and replacement-property or flight discovery still use the Trip Addon.
- For wheel-style or scrollable list pickers (birth date, document expiry, nationality/region, document type and similar controls), open the picker, inspect its current list, locate the requested option by its live value/name, and click that option directly; clicking the list container does not select a value. Verify the selected value and the saved field. Use the observed options rather than fixed positions. For date wheels that ignore clicks, read the installed Browser skill's mouse drag reference and follow the checkout reference's bounded recovery and date verification. Normal page, passenger-form and non-date list scrolling is allowed to reveal a target; use the active container. Use runtime-supported interactions and the checkout reference for bounded recovery. Ordinary text fields still use their supported fill workflow.
- Execute routine browser steps promptly: use a brief state check, act on the known target and verify the result. Do not deeply deliberate, re-plan or narrate between routine clicks/fills. Batch independent actions where supported; pause only for changed requirements, an actual error or the payment authorization step.
- If Trip says the search result or quote expired, automatically use its Reload/Search again control and resume the same selection with the latest quote; no user confirmation is needed to refresh, search again or continue filling merely because the price changed. Reuse collected details and restore only lost fields. Keep the user's itinerary/stay constraints and stopping point. Report the latest total at payment; refresh does not expand an existing payment authorization or budget.
- Preserve passenger, guest and contact details from the conversation, completed forms, handoff and current page; the latest user correction wins. Ask together only for required values that are missing, ambiguous or rejected. A known booking email also receives confirmations and e-tickets; do not ask for it again as a new contact field.
- Collect booking details as ordinary form fields: names, sex, nationality and document type/number use `text`; birth date and document expiry use `date`; contact details use `email`/`tel`. These are passenger data, not login credentials or payment-card inputs: do not request `secret` fields or temporary payment references for them. Pass submitted values to the booking subtask for automatic filling, including date-list selection. Keep passwords, tokens and payment-card details in their existing secure workflows; do not repeat identity values in progress messages or notes.
- Continue the selected booking through forms, skipped extras and payment-entry buttons to the final payment step. Do not audit fares, baggage, refunds or terms, open policy dialogs, compare alternatives or send interim confirmation requests. At payment, show the current booking summary and payable amount/currency once so the user can review them, then follow `agents-payment` (otherwise `purchases`). For any terms requested by the payment summary, include only information already available; label missing terms as not reviewed and leave review to the user, without opening policy pages. After authorization, finish the same unchanged booking without asking again.
- When the payment skill provides its own payment card, collect missing passenger/guest and contact details first and wait for that form's submission before starting the payment skill or displaying its card. Do not also request a credit-card form. Otherwise collect card fields in order: number, cardholder name, expiry, CVV; request only CVV for an otherwise usable saved card.
- Skip paid extras unless requested. Keep the selected option and explicit user constraints; do not reopen rate comparisons during checkout. Never book a mock result. After an uncertain submission, inspect the existing order before retrying; report only observed payment, reservation and ticketing status.

- Before returning a post-checkout screenshot for a flight or hotel, dismiss any optional sign-in, promotion or other nonessential popup obscuring the order, using its visible close/X control. Make at most one dismissal attempt in total for this screenshot, including any attempt already made while reading the order. If closing fails, the popup remains or reappears, or no close control is readily available, capture and return the current page immediately; briefly note the obstruction. Do not retry, sign in or delay the result just to obtain a cleaner screenshot. Required payment/bank verification is not an optional popup; report its actual status.

## Language

- Infer the reply language from the current user request without asking and pass it as `language` on every call, so a language change takes effect immediately.
- For Simplified Chinese pass `zh-CN`; the tool queries the backend with `zh-HK` content unless `locale` is given. For other languages use the matching BCP 47 code, such as `en-US` or `ja-JP`. If the language cannot be inferred, use `zh-HK`.
- Write surrounding prose and template labels in the reply language. Preserve returned product titles, route titles and promotion text verbatim.
- Pass `currency` on every call: it sets the returned prices and the currency the Trip.com booking page settles in. Use the currency the user names or will pay in (for example, the only currency their payment method supports); otherwise the currency of the user's country or region; `USD` when neither is known.

## Results and errors

Every tool returns JSON. A success is `{ requestId, deals, ... }`; a failure is `{ requestId, error: { code, message, retryable, fields? }, deals: [] }`.

- Explain `error.message` in the reply language without exposing `error.code`, `requestId`, field paths or raw JSON. Suggest retrying later only when `retryable` is true; otherwise ask for the corrected input, using `error.fields` to name only the values that need correction.
- `trip_api_not_configured` means the Trip.com service is not available in this environment yet; say so plainly and do not retry.
- `tool_disabled` means this kind of Trip.com search is switched off for now; say it is temporarily unavailable and do not retry it.
- A success with an empty `deals` list means nothing matched, not that the service failed. Do not call `show_results`. For flights and attractions, say no Trip.com results matched and suggest relaxing the most restrictive condition the user set (non-stop, airline, cabin, price, free cancellation, distance, dates); search again only if the user agrees. Hotel searches relax their filters on their own (see Hotels › Fallback), so an empty hotel result means nothing was found even without them: say so and suggest another area or dates.
- Never expose tool names, arguments, city codes, internal IDs or raw JSON to the user, except in mock mode below.
- **Mock mode.** A result with a `debug` object comes from sample data, not Trip.com. Start the reply with one line `> 🧪 Debug (mock): {debug.note}` translated into the reply language, then handle the result as usual: render the cards with the normal templates (keep the `[MOCK]` titles), or explain `error` as above. Only when `debug.trip_request` is present, end with the heading "Trip request (debug)" and `debug.trip_request` as a fenced JSON block. Never present mock results as real offers or prices, and never book one.
- **Result cards are required.** A Trip card is an Addon event created by `trip/show_results`, not a text summary, Markdown card or booking link. Searches never show cards: `card_ready: true` means ready to display, not delivered. Whenever you present nonempty selected search results, you MUST call `trip/show_results` before your final reply, asking the user to choose, or starting checkout. This also applies inside a subtask before reporting to its coordinator. Discover the tool if needed, then invoke it with action `call`; discovery alone does not display anything. A search with deals returns its `requestId`. First check the results answer the request (for hotels, that they are near the intended place; if they are clearly elsewhere, check the coordinates and search again, ignoring the wrong results). Then call `show_results` once with the `requestId` of the searches to show, normally the last good search. Several `requestId`s from the same tool, such as flight searches per arrival code, are merged into one card; call it once per tool when the user asked for different kinds of deals. Never show results you replaced with a new search, and never call `show_results` twice for the same results.
- After `show_results` returns `card_shown: true`, the user sees the deals as Trip.com cards (a horizontally scrollable row with image, price and a Book link). Do not repeat them as markdown cards or lists. Read `<skill_dir>/references/display.md` for the display rules. Reply with at most two short sentences: the useful selection sentence from those rules and, for hotels, the note that the user reviews the final booking details and total before payment. An `OVERVIEW` flight search replaces the selection sentence with its route overview (see Flights). Refer to deals by their exact titles.
- If `show_results` fails with `results_not_found`, search again once and show the new `requestId`. If display still fails, or the display tool is genuinely unavailable after discovery, say the Trip card could not be displayed and read `<skill_dir>/references/display.md` and render every deal individually with its product template and those compact-card rules. This is a failure fallback only; never voluntarily skip `show_results` or claim a card was displayed without `card_shown: true`. Do not rewrite titles, replace them with labels such as "Option 1", or summarize several deals into a list.
- Render prices, currencies and savings exactly as returned. Never calculate, convert or invent a price, discount or saving, and never add a per-night, per-person, tax, fee or round-trip basis the result does not state.
- The cards are where the user chooses. They pick by naming a deal or, where the card shows it, with its "Let <agent> do it" button, which sends the pick as their next message; the Book link only opens Trip.com and sends you nothing. Do not also offer the deals as reply options or a question listing them. When working on a task for a coordinator, call `show_results` yourself first and report whether it returned `card_shown: true`. Your final answer goes to the coordinator: also list each shown deal's exact title, price with its currency and basis (per night, total or per adult) exactly as returned, and link for relay. This text never replaces the required Addon card event; the two-sentence limit does not apply there, and this holds even when a booking skill says not to repeat the cards, because the coordinator cannot see the cards' items. Also say that the user picks with the card's "Let <agent> do it" button or by naming a deal, so no reply options are needed where the cards are shown.
- Make one search per request unless a rule below says otherwise; do not make extra searches to fill cards or the selection sentence.

## Trip timing

Apply these rules whenever flights and a stay are planned together, or a stay length is judged from flight times.

- A hotel night runs from the afternoon check-in (usually 14:00–15:00) to the next morning's checkout (usually 11:00–12:00), in the hotel's local time. Count a stay in hotel nights (check-out date minus check-in date), never in calendar days spent at the destination.
- A flight landing after midnight still needs the room from the night before: the check-in date is the day before the landing date (landing 00:55 on 10 Oct means checking in on 9 Oct). Tell the user the room is booked from the night of arrival so it is held for a late check-in. Such an arrival gives the same number of nights as an evening arrival on the previous day; never reject it as a night short.
- "3 days 2 nights" means two hotel nights between the outbound arrival and the return departure. A late-evening or after-midnight arrival and a return departing after the morning checkout both fit it.
- Flight times are local at each airport; `+1` marks arrival on the next local day. Do not convert time zones when matching flights to a stay.
- When pairing flights with a hotel search, derive `checkIn` and `checkOut` from the flight times with these rules, and state the check-in date whenever it differs from the landing date.

## Flights

Search Trip.com flight options for a route from a recent fare cache: each result is one bookable itinerary with times, airports, duration and price. Results come in Trip.com's recommended order, not sorted by price: keep that order and do not call a result the cheapest unless the returned prices show it.

- Pass both departure and arrival three-letter codes; they must differ. Each code is a city or metro area by default (`SHA` = all Shanghai airports); set `departureType` / `arrivalType` to `AIRPORT` when the user names an exact airport (`AIRPORT: SHA` = Hongqiao, `AIRPORT: PVG` = Pudong). A code with the `CITY` type must be a city or metro-area code: many airport codes differ from their city's code (Baku `BAK`, not `GYD`; Tokyo `TYO`, not `NRT`/`HND`; Sapporo `SPK`, not `CTS`; Xi'an `SIA`, not `XIY`), so use the city code, or keep the airport code and set its type to `AIRPORT`. A destination is required: if the user gives none, ask for it.
- If the destination maps to several city codes, call `search_flights` once per arrival code concurrently and merge the deals before rendering; show them with one `show_results` call listing every `requestId`.
- `startDate` and `endDate` bound the departure date (at most 7 days counting both, `endDate` defaults to `startDate`); `endDate` is never a return date. For round trips pass `tripType: RT` and `returnStartDate` (optional `returnEndDate`, also at most 7 days). `returnStartDate` cannot be earlier than the last departure date: for "any day next week, back two days later", search each departure date with its own return date instead of overlapping ranges. Split a departure window longer than 7 days into several searches.
- If Trip.com rejects a code (`INVALID_REQUEST` naming `departCityCode` / `arrivalCityCode`) and the code is not the main airport's own IATA code, search once more with that airport code and the `AIRPORT` type (Casablanca: `CMN`, not `CAS`). If it already is, Trip.com does not cover that airport: say so and offer a nearby hub. Never retry the same code with the other type.
- Passengers default to 1 adult, 0 children, 0 infants; pass the actual counts when known (adults plus children at most 9, infants at most adults). `limit` is 1 to 20, default 5.
- `classType` is `OVERVIEW` unless the user states a cabin preference. Users rarely name a cabin up front but would still take a business or first class seat they did not know was on sale, so do not default to economy. Pass `Y` (economy), `W` (premium economy), `C` (business) or `F` (first) only when the user names or clearly implies that cabin. `C` and `F` both return business and first class; `cabins` gives per cabin how many deals Trip.com `found`, how many fly that cabin on `allLegs`, and how many were `returned`. `isDirectOnly: true` returns non-stop flights only; omit it to allow connections. `airlineCode` filters both directions.
- Times of day and budgets: pass `departureTimeRange` / `returnTimeRange` as local `HH:MM` windows whenever the user names a time of day for a leg (morning 06:00–12:00, afternoon 12:00–18:00, evening 18:00–23:59, red-eye or overnight 22:00–06:00; "after 3 pm" is 15:00–23:59), and `maxPrice` for a price ceiling per adult (for one adult, the trip total). Trip.com cannot filter these, so the tool takes its most results, drops those over `maxPrice` and lists the flights in every window first (`matchesTimePreference: true`); `timePreference.matched` (and `inTimeWindow` per category in an overview) counts them. Present the matching flights; if none match, say so plainly and offer the closest times or prices instead of presenting them as matches. For a whole-party budget with several adults and no children, pass the budget divided by the adults.
- Seat choice (aisle or window), baggage and check-in cannot be set in a search: they follow booking, on the booking page or with the airline, whose online check-in usually opens 24 hours before departure. Say so when the user asks for them; they never stop the search.
- After a `C` or `F` search, answer for both cabins even if the user named one: whether the requested cabin covers every leg, some legs or none, and the other cabin's lowest price (or its `found` count when none was returned).
- An `OVERVIEW` search returns flight counts for economy, business/first and mixed-cabin itineraries, plus a few picked deals; `limit` does not apply. Counts cover Trip.com's first results: say "at least" when `atLeast` is true, and never "none" for a category with `atLeast: true`. Do not say cabins in `cabinsNotSearched` have no seats.
- After an `OVERVIEW` search, start the reply with the route overview: dates and route; non-stop, connecting and business/first counts (say plainly when there are none; mention mixed-cabin options if any); then the lowest fare, a notable non-stop and the lowest business/first fare, each with flight, stops and price. For example: "Singapore to Wuhan on 23–24 Oct: 5 non-stop and 9 connecting flights, plus 3 business class options. The lowest is Scoot TR120 non-stop at SGD 208; for more comfort, MU2578 in business class is SGD 995."

Card fields: required `title`, `departureDate`, `tripType`, `bookingLinks`, `currentPrice`, `currency`, `priceBasis`, `journeys`; optional `returnDate`, `discountLabel`, `airlineName`, `flightNumbers`, `cabinLabel`, `nonstopLabel`, `originalPrice`, `savingsAmount`, `cacheUpdatedAt`. Each journey carries its departure and arrival airports, local times, duration and connection count. Keep flights without a discount or original price, and never borrow facts from another result.

- `priceBasis: ADULT_UNIT_PRICE` means the price is per adult, not the total for every passenger and not proof of taxes included.
- **Prices are cached.** Flight cards already carry the note that fares change often and the booking page shows the final price, so do not repeat it after `show_results` succeeds. When flights are rendered as text instead, add that note as one short sentence in the reply language; with the `CACHED_FARES` warning it is mandatory. The Book link opens booking and repricing; it does not reserve a seat.
- For the link use `bookingLinks.online`, otherwise `bookingLinks.h5`; keep the URL intact.

```text
✈️ **{title}** · {departure_summary} · {trip_type_label}
**{currency} {currentPrice}** {price_basis_label} · 🏷️ **{discount_summary}**
{original_price_label} ~~{currency} {originalPrice}~~ · {savings_summary}
{airlineName} {flightNumbers} · {times_and_duration} · {nonstopLabel} · {cabinLabel} · [{view_details_label}]({booking_link})
```

- Keep the route and actual departure date (and return date for round trips) on the first line; retain the year when needed to avoid ambiguity. Translate `OW` / `RT` into a one-way / round-trip label and the per-adult basis into the reply language.
- Use the returned `discountLabel` as `{discount_summary}`; if absent, omit the offer and icon. If neither reference price nor savings is present, omit the whole third line.
- Bold only the route title, current price and returned discount. Join `flightNumbers` in their returned order with `, `. `{times_and_duration}` is the outbound departure and arrival time (mark a next-day arrival) and duration. A missing non-stop label does not establish a connection. The link label should mean "View flight".
- In the selection sentence, identify a choice by route, departure date and time, adding airline or flight numbers only to distinguish otherwise identical choices.

## Hotels

Search and recommend Trip.com hotels. Read `<skill_dir>/references/hotel-search.md` before applying any optional filter, sort or page control.

### Destination

`destinationType`, `cityName` and the country are required on every search. Choose the type from what scopes the stay:

- `CITY`: the user wants a hotel anywhere in the city, or only names the city. Pass the city in `cityName`; no coordinates and no `name`. Trip.com ranks the whole city, which recommends better than a point at the city centre.
- `HOTEL`: the user names a specific hotel. Pass its name in `name` as the user wrote it or as officially spelled, and its city in `cityName`; no coordinates.
- `POI`: the user wants to stay near a specific place (a station, airport terminal, landmark, venue, address or district). Pass the place's `latitude`/`longitude` and its name in `name`, which labels the distance texts. Keep that place; never broaden it to the city or replace it with a nearby peer.

For `POI` coordinates, pass WGS84 decimal degrees (the GPS system used by OpenStreetMap and Wikipedia) everywhere, including mainland China, Hong Kong and Macau; the tool converts them where Trip.com needs another system. Use coordinates you know precisely for well-known places; otherwise look the place up first (for example with a web search) and take the point from a WGS84 source. Never use points from Amap (Gaode), Baidu, Tencent Maps or Google Maps inside mainland China, which are shifted by several hundred metres. Never invent, approximate or reuse another place's coordinates.

- Put the containing city in `cityName` so results stay within it, and pass the country or region as `countryName` (any language, e.g. `Japan`, `中国`, `Hong Kong`) or `countryCode` (e.g. `JP`, `CN`, `HK`; prefer the name, and use `UK`, not `GB`). It also disambiguates cities such as Sydney or London.
- `distanceKm` and the distance sorts only work with `POI`; for "near X" requests, search `POI` at X.
- Trip.com knows cities, not every resort area, beach town or neighbourhood. For places such as Seminyak, Uluwatu or Zahara de los Atunes, search `POI` with the place's coordinates and `name`, and put the city or region Trip.com lists them under in `cityName` (Bali; Barbate or Cádiz). If a `CITY` search returns `DESTINATION_NOT_FOUND`, retry this way once.
- A hotel request always ends with cards to choose from, not with a question. If the city, place or hotel is ambiguous, search the most likely reading and state it in the sentence after the cards. Ask one focused question only when there is no destination at all, or a child's age is missing. Never guess IDs or child ages.
- The user chooses the hotel, even when they asked you to book. After `show_results`, end the turn with the cards and the sentence after them. Until the user picks a hotel (by naming it or with the card's book button), do not open a hotel page, start a booking or ask for payment. When the user wants the cheapest, search with `sortBy: PRICE`, `sortOrder: ASC` and `pageSize: 2` and say which card is cheaper; for one named hotel, show its card. The user still picks from the card. When you are working on a task for a coordinator, end with a final answer saying the hotel cards are waiting for the user's choice.

### Stay and filters

- Dates use `YYYY-MM-DD`; check-out must be later than check-in. Always pass both `checkIn` and `checkOut`: when the user gives no dates, use tomorrow and the following day in the user's local date. The tool's own fallback runs on the server clock and can be off by a day.
- `roomCount` and `adults` are positive integers with adults not below rooms; defaults are 1 room and 2 adults. Every child needs an age from 0 through 17 in `childAges`. Do not convert twin beds into two rooms or a bed count.
- Trip.com cannot filter by number of beds, bathrooms or homestay bedrooms; say so when asked and point the user to the room details on the booking page. Pass `meals` as one value unless the user accepts alternatives, and never combine a meal with its own variants (`BREAKFAST` with `ONE_BREAKFAST`).
- `sortOrder` matters only for `PRICE` (`ASC` = cheapest first, the default); every other sort has a fixed direction.
- Omit optional filters and sort the user did not request, and do not silently drop unsupported or conflicting ones. The default `pageSize` is 5; pass another value from 1 through 20 only when the user asks. Omit `pageIndex` for the first page.

### Requirements and fallback

Users describe many things; map only what selects a hotel. Pass every supported requirement as a filter in the first search, so the hotels meeting all of them come first. Leave out what cannot be searched (views, quietness, specific room rates) and check it on the Trip.com page after the user picks a hotel. Put the filters the user insists on ("must", "only", "has to") in `mustHave` too.

When fewer than 3 hotels match every filter, the tool also searches with the least important filters dropped and returns both (details in [references/hotel-search.md](references/hotel-search.md#fallback-when-few-hotels-match)). Show those results with `show_results` as usual; never ask whether to relax first. When the result has `relaxation`, the sentence after the cards says plainly which requirements the first `relaxation.fullMatches` hotels meet and which of the user's requirements (`relaxation.relaxedFilters`, in the user's words) the other hotels were not checked against, without listing per-hotel details. A hotel with `unverified_filters` is never described as meeting those requirements. When the user picks such a hotel to book, check those requirements on its Trip.com page and tell the user before going on.

### Conversation modes

Use `progressive`, and switch to `confirm-first` only when the user explicitly asks to review the search before it runs; keep the selected mode for later hotel searches in the conversation.

- `progressive`: search as soon as the destination is usable, including any supported values already supplied. After the results ask at most one concise follow-up about a relevant unresolved or invalid preference.
- `confirm-first`: preview the destination (city, place or hotel), dates, occupancy, filters, sort and page size, recommending tomorrow, the following day, 1 room, 2 adults, no children and no optional filters where the user said nothing. Search after the user confirms or corrects it in one reply.

When the user switches modes, apply the new mode immediately. If they only ask to compare modes, explain the timing trade-off and ask which to use without searching.

At the first actual hotel search in a conversation, read `<skill_dir>/references/hotel-query-examples.md` and show one natural-language example of a richer search following its rules: after the results when searching now (first stating any default dates and occupancy used), or after the question when a clarification blocks the search. Show it once per conversation, never on refinements, pagination, retries or language changes, and not when the user wants results only.

### Pagination

Fetch one page per search. When the user asks for more, repeat the confirmed query with `pageIndex` incremented (an initial query without an index is page 1) and the same `pageSize`; after a fallback, repeat it without the filters in `relaxation.relaxedFilters`. Stop when a page returns nothing or the cumulative count reaches `pagination.totalCount`.

### Hotel cards

A success also contains `searchContext`, `appliedFilters`, `pagination`, optional `sort`, `relaxation` and `warnings`. Deal fields: required `product_type`, `title`, `category_label`, `deeplink`; optional `star`, `star_type`, `rating`, `rating_scale`, `rating_label`, `review_count`, `address`, `destination_city`, `relative_position`, `availability_status`, `availability_text`, `price`, `discount`, `promotion_label`, `cancellation_policy_label`, `breakfast_label`, `unverified_filters`.

```text
**{title}**
💰 **{current_price_label} {price.currency} {price.display_price}** · {original_price_label} ~~{price.currency} {price.original_price}~~ · 🏷️ **{discount_summary}** · **{savings_summary}** · [{view_details_label}]({deeplink})
{star_description} · {rating}/{rating_scale} {rating_label} · {review_count_label} · {availability_summary}
📍 {address}{relative_position_separator}{relative_position}
```

- `price.display_price` is the current displayed price and `price.original_price` the displayed comparison price; `price.savings_amount` is the saving against it. If `display_price` is absent, keep the link and any offer without inventing a price.
- A `discount.ratio` between 0 and 1 gives `{discount_summary}` as the localized equivalent of `{discount.percent}% off`, without recomputing it. Otherwise use `promotion_label` verbatim, or omit the offer and icon. Never infer a discount from labels, promotion text or the price difference.
- Interpret `star` with `star_type`: `STAR` is a star rating and `DIAMOND` a diamond rating; for any other type, including `DOT`, omit `{star_description}`. Render `rating` against `rating_scale` only when both are present; never assume a 10-point scale.
- For `AVAILABLE`, say the hotel is currently bookable and include any `availability_text` once. For another status, say so and do not present the hotel as a primary recommendation. An absent status is unknown.
- `cancellation_policy_label` and `breakfast_label` are Trip's short policy summaries (for example "Free cancellation", "Non-refundable", "Breakfast included", "不含早餐") for answering hotel questions. Quote the returned text; it can be negative. An absent label means unknown: never say a hotel is non-refundable or has no breakfast because the label is missing. Do not infer cancellation deadlines, penalties, breakfast quantities or room-specific guarantees from them.
- Hotel detail dialogs and in-app detail pages show these labels when present; compact lists and the text template stay unchanged. Do not repeat the labels after showing cards unless they answer the user's question, and never claim that a displayed label guarantees the selected room's terms.
- When the user asks which results offer free cancellation or breakfast, answer from these labels. When they want only such hotels, search again with `bookingPolicies: [FREE_CANCELLATION]` or `meals: [BREAKFAST]` (also in `mustHave`) instead of dropping results that lack a label.
- Use `address`, falling back to `destination_city`; add the relative-position separator only when both location fragments exist.
- Hotel prices are tax-inclusive by default: the total for the stay, or per night when the user set a budget; `appliedFilters.priceDisplay` states which. Whenever a hotel price appears in text, give its basis (total for N nights, or per night) and whether taxes are included; never present a pre-tax or nightly price as the amount to pay. Use pre-tax prices only when the user asks for them, and say so.
- After the cards, state once that the user reviews the final room details and total before payment. The search returns hotel-level prices; filters such as payment type or breakfast do not establish the terms of a specific room rate.
- Treat `warnings` as diagnostics; mention one only when it materially changes a requested filter.

## Attraction tickets, experiences and travel services

`search_attractions` searches Trip.com's discounted product pool in a city. Pass the destination city name in the user's language or English, never a code or numeric ID, and add its country as `countryName` whenever the city name could exist in more than one country (`countryCode` only as a fallback). `limit` defaults to 3. SIM-card products are excluded unless `excludeSim` is false. Sold-out items are excluded and results are sorted by discount strength.

Card fields: required `product_type`, `title`, `category_label`, `current_price`, `currency`, `deeplink`; optional `original_price`, `savings_amount`, `discount_label`, `valid_until`, `promo_tag`, `destination_city`, `redemption_note`.

```text
**{title}** · {category_label}
💰 **{currency} {current_price}** · {original_price_label} ~~{currency} {original_price}~~ · 🏷️ **{discount_summary}** · **{savings_summary}** · [{view_details_label}]({deeplink})
📍 {destination_city}
{promo_tag} · {valid_until_label} {valid_until}
```

- Use the returned `discount_label` as `{discount_summary}`, falling back to `promo_tag` when it describes an actual offer; if neither is present, omit the offer and icon. Do not repeat a `promo_tag` already used as the offer; keep distinct promotion and validity text in normal weight and omit an empty line.
- Append `redemption_note` to the destination line only when it adds information beyond the title (ignoring whitespace, line wrapping and Markdown decoration).
- Translate `valid_until_label`, `original_price_label` and `view_details_label` into the reply language.
