---
title: Python one-liners (book compilation, corrected)
aliases: [250+ Killer Python One-Liners, python book one-liners]
tags: [python, one-liners, reference, errata]
source: "Hernando Abella, 250+ Killer Python One-Liners (Aluna Publishing House)"
verified_with: Python 3.14.6
created: 2026-10-01
updated: 2026-10-01
---

# Python one-liners: book compilation (tested and corrected)

> [!NOTE]
> All **264** entries from *250+ Killer Python One-Liners* by Hernando Abella, tested and corrected. For original one-liners see [python-one-liners.md](python-one-liners.md); for shell tools see [sed-awk-bioawk-one-liners.md](sed-awk-bioawk-one-liners.md).

## What "tested and corrected" means

- **Every snippet is executed.** The `text` block under it is its real output, and `python3 scripts/verify_blocks.py python-one-liners-book.md` re-checks all of them.
- **Every `# Output:` comment was regenerated from real execution.** The book's hand-written output claims were removed first, because 30 of them were wrong. Snippets with random or date-dependent output say `# Output (varies), e.g.:`.
- **56 entries had a problem in the book:**
  - **33** had wrong logic or a dangerous edge case, and now contain **corrected code**. The book's original code is shown under each one for reference.
  - **22** had correct code but a wrong stated output, which is now fixed by the regenerated comments.
  - **1** carry an explanatory note only.

  See the [corrections log](#corrections-log).
- Text extraction from the PDF lost indentation and injected spaces at line wraps. Those artifacts were repaired, and the 7 entries whose indentation was ambiguous say so.

## Corrections log

| # | Entry | Fix | What was wrong in the book |
|---|---|---|---|
| [2](#2-swap-two-variables) | Swap Two Variables | code corrected | The `print` swaps the labels. |
| [9](#9-find-the-frecuency-of-character-in-a-string) | Find the Frecuency of Character in a String | code corrected | `set()` iteration order is arbitrary, so the order of the printed pairs varies between runs. |
| [12](#12-find-the-odd-occurrence) | Find the Odd Occurrence | code corrected | XOR-reduce only finds the odd-one-out when exactly one value occurs an odd number of times. |
| [20](#20-validate-vowel-sandwich) | Validate Vowel Sandwich | output comment corrected | `bat` and `dog` are both consonant-vowel-consonant, so the code returns `True` for them. |
| [24](#24-move-capital-letters-to-front) | Move Capital Letters to Front | output comment corrected | The real output is `MCLTFoveapitalettersoront`. |
| [26](#26-validate-number-within-bounds) | Validate Number Within Bounds | code corrected | The description says *exclusively* within bounds, but `lower <= n` makes the lower bound inclusive, so `(5, 5, 20)` returns `True` (book: `False`). |
| [30](#30-jazzify-chords) | Jazzify Chords | code corrected | It adds the *number* 7 (`1 -> 8`) instead of appending `"7"` to a chord name (`"C" -> "C7"`). |
| [36](#36-calculate-the-power-of-a-number) | Calculate the Power of a Number | output comment corrected | `2  5` is an `int`, so it prints `32`, not `32.0`. |
| [45](#45-calculate-progress-days) | Calculate Progress Days | output comment corrected | Returns `4`, not `3`: the increases are 3<4, 1<2, 2<4 and 4<5. |
| [50](#50-convert-dna-to-rna) | Convert DNA to RNA | code corrected | Biology error. The map `A->U, T->A, C->G, G->C` is the complement transcribed from the *template* strand, read 3'->5' without reversing. |
| [67](#67-check-if-a-number-is-a-power-of-two) | Check if a Number is a Power of Two | code corrected | `0 & -1 == 0`, so `IsPowerOfTwo(0)` returns `True`. |
| [69](#69-shhh-whisperer) | Shhh Whisperer | code corrected | It inserts a space and lowercases the first letter, printing `"h ello there", whispered your friend.`. |
| [80](#80-binary-letter-converter) | Binary Letter Converter | output comment corrected | `o`, `r` and `w` come after `m`, so `hello -> 00001` and `world -> 11100`. |
| [82](#82-convert-days-to-years-months-and-days) | Convert Days to Years, Months, and Days | output comment corrected | `1000 % 365 = 270` and `270 % 30 = 0`, so the result is `2 years, 9 months, and 0 days` (book: `5 days`). |
| [91](#91-calculate-the-standard-deviation-of-an-array-of-numbers) | Calculate the Standard Deviation of an Array of Numbers | note | This is the *population* SD (divides by n). |
| [98](#98-simple-calculator) | Simple calculator | code corrected | The dict evaluates every operation up front, so `calculator(1, '+', 0)` raises `ZeroDivisionError`. |
| [99](#99-find-nemo) | Find Nemo | output comment corrected | In "I am finding Nemo", Nemo is word 4 and the code prints 4. |
| [113](#113-maurices-racing-snails) | Maurice's Racing Snails | code corrected | With `[1,2,3]` vs `[3,2,1]` only `3 > 1` wins, so the result is `False` (book: `True`). |
| [120](#120-find-the-longest-common-prefix-in-an-array-of-strings) | Find the Longest Common Prefix in an Array of Strings | code corrected | This isn't a prefix. |
| [140](#140-find-the-largest-prime-factor-of-a-number) | Find the Largest Prime Factor of a Number | code corrected | Returns the smallest prime factor. |
| [141](#141-check-if-a-number-is-a-pronic-square) | Check if a Number is a Pronic Square | code corrected | The code tests for a perfect square, so 6 and 21 both return `False` (book: `True`). |
| [142](#142-world-landmass-proportion-calculator) | World Landmass Proportion Calculator | output comment corrected | 9984670 x 100 / 148940000 = 6.7038, which prints as `6.70%` (book: `6.71%`). |
| [143](#143-loaded-die-detection) | Loaded Die Detection | code corrected | This isn't a statistical test. |
| [145](#145-check-if-a-number-is-a-happy-number) | Check if a Number is a Happy Number | code corrected | It hard-codes a few guesses instead of iterating sum-of-squared-digits. |
| [155](#155-missing-number-finder) | Missing Number Finder | code corrected | Hard-codes `55` = 1+...+10, so it only works for exactly 1..10. |
| [156](#156-calculate-the-volume-of-a-cylinder) | Calculate the Volume of a Cylinder | output comment corrected | Python prints `785.3981633974483`; the book drops a digit. |
| [158](#158-convert-decimal-number-to-octal) | Convert Decimal Number to Octal | code corrected | `lstrip("0o")` strips *characters*, not a prefix, so `decimal_to_octal(0)` returns `''`. |
| [169](#169-convert-decimal-number-to-hexadecimal) | Convert Decimal Number to Hexadecimal | code corrected | Same `lstrip` bug as #158: `decimal_to_hex(0)` returns `''`. |
| [174](#174-diving-minigame-checker) | Diving Minigame Checker | code corrected | All four test cases print `False`. |
| [178](#178-check-if-a-string-is-a-valid-credit-card-number-visa-mastercard-discover-american-express) | Check if a String is a Valid Credit Card Number (Visa, MasterCard, Discover, American Express) | code corrected | This checks the format only, with no Luhn checksum. |
| [180](#180-check-if-a-number-is-a-vampire-number) | Check if a Number is a Vampire Number | code corrected | Once indentation is restored (`return False` after the loop) the example works. |
| [184](#184-calculate-the-area-of-a-trapezoid) | Calculate the Area of a Trapezoid | output comment corrected | `0.5 * ...` is a float, so it prints `36.0`. |
| [185](#185-check-if-a-number-is-a-kaprekar-number) | Check if a Number is a Kaprekar Number | code corrected | Wrong split: the left part must be the *remaining* digits. |
| [194](#194-calculate-the-area-of-a-circle-sector) | Calculate the Area of a Circle Sector | output comment corrected | Python prints `19.634954084936208`. |
| [198](#198-check-if-a-number-is-a-leyland-number) | Check if a Number is a Leyland Number | code corrected | With indentation restored, `30 -> False` and `100 -> True` (100 = 2^6 + 6^2). |
| [199](#199-generate-a-random-uuid) | Generate a Random UUID | code corrected | This isn't an RFC 4122 UUID: the variant nibble is random. |
| [200](#200-check-if-a-string-is-a-valid-ipv6-address) | Check if a String is a Valid IPv6 Address | code corrected | Only the full 8-group form matches, so the compressed `2001:0db8:85a3::8a2e:0370:7334` returns `False` (book: `True`). |
| [208](#208-calculate-iterated-square-root) | Calculate Iterated Square Root | code corrected | Computes floor(log2(sqrt n)), not the iterated square root (how many square roots until the value drops below 2): 16 -> 4 -> 2 -> 1.41 takes 3. |
| [212](#212-detect-syncopation-in-music) | Detect Syncopation in Music | output comment corrected | `'#.#.#'` returns `False` and `'###'` returns `True`, the opposite of the book for both. |
| [213](#213-extend-vowels-in-a-word) | Extend Vowels in a Word | output comment corrected | Each vowel is repeated `num+1` times, so `("hello", 2)` gives `heeellooo`. |
| [217](#217-bigint-decimal-string-formatter) | BigInt Decimal String Formatter | output comment corrected | A 30-digit integer with 5 decimals gives `1234567890123456789012345.67890`. |
| [218](#218-check-if-a-number-is-a-reversible-number) | Check if a Number is a Reversible Number | code corrected | Wrong definition. |
| [223](#223-check-if-a-number-is-a-unitary-perfect-number) | Check if a Number is a Unitary Perfect Number | code corrected | It tests `gcd(num, i) == 1` instead of `gcd(d, num // d) == 1`, so the sum is always 1. |
| [225](#225-calculate-the-area-of-an-equilateral-triangle) | Calculate the Area of an Equilateral Triangle | output comment corrected | Python prints `10.825317547305483`. |
| [226](#226-check-if-a-number-is-a-harshad-smith-number) | Check if a Number is a Harshad Smith Number | code corrected | It requires the number to be prime and equal to its own digit sum, so 22 returns `False` (book: `True`). |
| [227](#227-check-if-a-number-is-a-perfect-power) | Check if a Number is a Perfect Power | output comment corrected | 25 = 5^2 *is* a perfect power. |
| [231](#231-calculate-the-volume-of-a-pyramid) | Calculate the Volume of a Pyramid | output comment corrected | Python prints `83.33333333333331`. |
| [232](#232-check-if-a-number-is-a-wedderburn-etherington-number) | Check if a Number is a Wedderburn-Etherington Number | code corrected | `functools` and `operator` are never imported. |
| [235](#235-calculate-the-area-of-a-regular-octagon) | Calculate the Area of a Regular Octagon | output comment corrected | The book's `86.60...` is wrong: 2(1+sqrt 2) x 25 = 120.71. |
| [236](#236-check-if-a-number-is-a-repunit-number) | Check if a Number is a Repunit Number | output comment corrected | 11 *is* a repunit. |
| [237](#237-calculate-the-volume-of-an-ellipsoid) | Calculate the Volume of an Ellipsoid | output comment corrected | Python prints `125.66370614359171`. |
| [239](#239-check-if-a-string-is-a-valid-tax-identification-number-tin) | Check if a String is a Valid Tax Identification Number (TIN) | code corrected | The pattern `AA999999XX` is invented; real TIN formats are country-specific. |
| [240](#240-check-if-a-string-is-a-valid-isbn-international-standard-book-number) | Check if a String is a Valid ISBN (International Standard Book Number) | code corrected | `'123456789'` has 9 characters and ISBN-10 has 10, so the code returns `False` (book: `True`). |
| [241](#241-check-if-a-string-is-a-valid-ip-address) | Check if a String is a Valid IP Address | code corrected | `inet_aton` accepts shorthand such as `'127.1'` and `'1'`. |
| [260](#260-calculate-the-distance-between-two-points-in-a-2d-plane) | Calculate the Distance between Two Points in a 2D Plane | output comment corrected | `math.sqrt` returns a float, so it prints `5.0`. |
| [264](#264-calculate-the-area-of-a-sector) | Calculate the Area of a Sector | output comment corrected | The book's `5.2359...` is wrong: pi x 25 x 60 / 360 = 13.09. |

## Index by topic

- **Strings** (48): [7 Capitalize a String](#7-capitalize-a-string) · [9 Find the Frecuency of Character in a String](#9-find-the-frecuency-of-character-in-a-string) · [16 Reverse a String](#16-reverse-a-string) · [20 Validate Vowel Sandwich](#20-validate-vowel-sandwich) · [22 Get the Length of a String](#22-get-the-length-of-a-string) · [24 Move Capital Letters to Front](#24-move-capital-letters-to-front) · [30 Jazzify Chords](#30-jazzify-chords) · [39 Count the Number of Words in a String](#39-count-the-number-of-words-in-a-string) · [43 Check if a String is Empty](#43-check-if-a-string-is-empty) · [49 Check if a String starts with a specific character](#49-check-if-a-string-starts-with-a-specific-character) · [58 Truncate a String to a Given Length](#58-truncate-a-string-to-a-given-length) · [64 Spell Out a Word](#64-spell-out-a-word) · [69 Shhh Whisperer](#69-shhh-whisperer) · [71 Find the Bomb](#71-find-the-bomb) · [74 Check if a String contains only Numbers](#74-check-if-a-string-contains-only-numbers) · [85 Remove Whitespace from a String](#85-remove-whitespace-from-a-string) · [92 Check if a String ends with a specific Substring](#92-check-if-a-string-ends-with-a-specific-substring) · [99 Find Nemo](#99-find-nemo) · [100 Count the occurrences of a character in a String](#100-count-the-occurrences-of-a-character-in-a-string) · [102 Remove Duplicates from a String](#102-remove-duplicates-from-a-string) · [108 Capitalize the First Letter of Each Word in a String](#108-capitalize-the-first-letter-of-each-word-in-a-string) · [120 Find the Longest Common Prefix in an Array of Strings](#120-find-the-longest-common-prefix-in-an-array-of-strings) · [122 Find the First Non-Repeated Character in a String](#122-find-the-first-non-repeated-character-in-a-string) · [125 Check if a String is an Anagram of Another String](#125-check-if-a-string-is-an-anagram-of-another-string) · [126 Compact Phone Number Formatter](#126-compact-phone-number-formatter) · [130 Remove Vowels from a String](#130-remove-vowels-from-a-string) · [133 Check if a String is a Pangram](#133-check-if-a-string-is-a-pangram) · [134 Reverse the Order of Words in a Sentence](#134-reverse-the-order-of-words-in-a-sentence) · [137 Count the Letters in a String (case-insensitive)](#137-count-the-letters-in-a-string-case-insensitive) · [149 Double Letter Checker](#149-double-letter-checker) · [150 Find the Length of the Longest Word in a Sentence](#150-find-the-length-of-the-longest-word-in-a-sentence) · [162 Vowel Dasher](#162-vowel-dasher) · [167 XO Checker](#167-xo-checker) · [176 Middle Character of String](#176-middle-character-of-string) · [205 Neutralize Strings Interaction](#205-neutralize-strings-interaction) · [210 Replace Sausages with "Wurst”](#210-replace-sausages-with-wurst) · [213 Extend Vowels in a Word](#213-extend-vowels-in-a-word) · [217 BigInt Decimal String Formatter](#217-bigint-decimal-string-formatter) · [220 Find the Shortest Word in a String](#220-find-the-shortest-word-in-a-string) · [221 Find the Longest Word Length in a String](#221-find-the-longest-word-length-in-a-string) · [242 Reverse a String (Using Recursion)](#242-reverse-a-string-using-recursion) · [249 Check if a String is a Palindrome (Ignoring Non-Alphanumeric Characters)](#249-check-if-a-string-is-a-palindrome-ignoring-non-alphanumeric-characters) · [254 Count the Vowels in a String](#254-count-the-vowels-in-a-string) · [257 Find the ASCII Value of a Character](#257-find-the-ascii-value-of-a-character) · [258 Check if a String is an Isogram (No Repeating Characters)](#258-check-if-a-string-is-an-isogram-no-repeating-characters) · [259 Calculate the Hamming Distance of Two Strings (Equal Length)](#259-calculate-the-hamming-distance-of-two-strings-equal-length) · [261 Check if a String is a Positive Number (No Sign or Decimal Allowed)](#261-check-if-a-string-is-a-positive-number-no-sign-or-decimal-allowed) · [262 Find the First Non-Repeating Character in a String](#262-find-the-first-non-repeating-character-in-a-string)
- **Lists & arrays** (45): [4 Transpose of a Matrix](#4-transpose-of-a-matrix) · [17 Check If Array is Empty](#17-check-if-array-is-empty) · [21 Count True Values in Boolean Array](#21-count-true-values-in-boolean-array) · [25 Check if an Array is Special](#25-check-if-an-array-is-special) · [29 Get the Last Element of an Array](#29-get-the-last-element-of-an-array) · [31 Check if All Elements in an Array are the Same](#31-check-if-all-elements-in-an-array-are-the-same) · [33 Sum all Numbers in an Array](#33-sum-all-numbers-in-an-array) · [34 Find the Maximum Value in an Array](#34-find-the-maximum-value-in-an-array) · [44 Sum of Index Multiplied Elements](#44-sum-of-index-multiplied-elements) · [45 Calculate Progress Days](#45-calculate-progress-days) · [48 Find the Maximum Value in an Array of Objects](#48-find-the-maximum-value-in-an-array-of-objects) · [51 Check if an array contains a specific value](#51-check-if-an-array-contains-a-specific-value) · [54 Find the Index of an Element in an Array](#54-find-the-index-of-an-element-in-an-array) · [56 Check if an Array is Sorted in Ascending Order](#56-check-if-an-array-is-sorted-in-ascending-order) · [57 Remove a Specific Element from an Array](#57-remove-a-specific-element-from-an-array) · [65 Check if an Array contains only Unique Values](#65-check-if-an-array-contains-only-unique-values) · [78 Get the Last N Elements of an Array](#78-get-the-last-n-elements-of-an-array) · [81 Find the Intersection of Two Arrays](#81-find-the-intersection-of-two-arrays) · [86 Find the Difference between Two Arrays](#86-find-the-difference-between-two-arrays) · [89 Get the First N Elements of an Array](#89-get-the-first-n-elements-of-an-array) · [93 Calculate the Sum of Squares of an Array](#93-calculate-the-sum-of-squares-of-an-array) · [103 Find the Mode of an Array of Numbers](#103-find-the-mode-of-an-array-of-numbers) · [106 Check if an Array is Sorted in Descending Order](#106-check-if-an-array-is-sorted-in-descending-order) · [107 Find the Average of Even Numbers in an Array](#107-find-the-average-of-even-numbers-in-an-array) · [109 Check if an Array is a Subset of Another Array](#109-check-if-an-array-is-a-subset-of-another-array) · [110 Find the Minimum and Maximum Numbers in an Array](#110-find-the-minimum-and-maximum-numbers-in-an-array) · [112 Remove Null Values from a List](#112-remove-null-values-from-a-list) · [114 Calculate the Sum of Cubes of an Array](#114-calculate-the-sum-of-cubes-of-an-array) · [131 Generate an Array of Consecutive Numbers](#131-generate-an-array-of-consecutive-numbers) · [136 Find the Average of Odd Numbers in an Array](#136-find-the-average-of-odd-numbers-in-an-array) · [154 Calculate the Sum of Even Numbers in an Array](#154-calculate-the-sum-of-even-numbers-in-an-array) · [181 Obsolete Sum Converter](#181-obsolete-sum-converter) · [196 Remove Duplicates from Array](#196-remove-duplicates-from-array) · [228 Drop Elements from Array](#228-drop-elements-from-array) · [229 Maximum Total of Last Five Elements in an Array](#229-maximum-total-of-last-five-elements-in-an-array) · [234 Find the Second Largest Number in an Array](#234-find-the-second-largest-number-in-an-array) · [243 Count the Occurrences of Each Element in an Array](#243-count-the-occurrences-of-each-element-in-an-array) · [244 Check if Two Arrays are Equal](#244-check-if-two-arrays-are-equal) · [245 Find the Minimum Value in an Array](#245-find-the-minimum-value-in-an-array) · [246 Flatten an Array of Nested Arrays](#246-flatten-an-array-of-nested-arrays) · [247 Find the Average of Numbers in an Array](#247-find-the-average-of-numbers-in-an-array) · [248 Sum the Squares of Numbers in an Array](#248-sum-the-squares-of-numbers-in-an-array) · [250 Find Bob in a List](#250-find-bob-in-a-list) · [252 Move Zeros to the End](#252-move-zeros-to-the-end) · [253 Find the Median of Numbers in an Array](#253-find-the-median-of-numbers-in-an-array)
- **Math & arithmetic** (21): [14 Simple Sum](#14-simple-sum) · [32 Sum of Numbers up to a Given Number](#32-sum-of-numbers-up-to-a-given-number) · [36 Calculate the Power of a Number](#36-calculate-the-power-of-a-number) · [68 Generate multiplication table](#68-generate-multiplication-table) · [91 Calculate the Standard Deviation of an Array of Numbers](#91-calculate-the-standard-deviation-of-an-array-of-numbers) · [94 Calculate PI to N Decimal Places](#94-calculate-pi-to-n-decimal-places) · [98 Simple calculator](#98-simple-calculator) · [123 One-Liner Bitwise Operations in Python](#123-one-liner-bitwise-operations-in-python) · [124 Calculate the Exponential of a Number](#124-calculate-the-exponential-of-a-number) · [142 World Landmass Proportion Calculator](#142-world-landmass-proportion-calculator) · [144 Hand Washing Duration Calculator](#144-hand-washing-duration-calculator) · [148 Discounted Price Calculator](#148-discounted-price-calculator) · [151 Stolen Items Loss Calculator](#151-stolen-items-loss-calculator) · [159 Collatz Sequence Analyzer](#159-collatz-sequence-analyzer) · [161 Find the Sum of the First N Natural Numbers](#161-find-the-sum-of-the-first-n-natural-numbers) · [175 Roger's Shooting Score Calculator](#175-rogers-shooting-score-calculator) · [190 Calculate Boxes in Algebra Sequence](#190-calculate-boxes-in-algebra-sequence) · [192 Triangular Number Sequence](#192-triangular-number-sequence) · [207 Calculate War of Numbers](#207-calculate-war-of-numbers) · [208 Calculate Iterated Square Root](#208-calculate-iterated-square-root) · [255 Calculate Vote Difference](#255-calculate-vote-difference)
- **Number properties** (36): [13 Check if a Number is Even or Odd](#13-check-if-a-number-is-even-or-odd) · [26 Validate Number Within Bounds](#26-validate-number-within-bounds) · [40 Count Ones in Binary Representation](#40-count-ones-in-binary-representation) · [46 Check if a Number is a Multiple of 5](#46-check-if-a-number-is-a-multiple-of-5) · [63 Generate a Fibonacci Sequence](#63-generate-a-fibonacci-sequence) · [67 Check if a Number is a Power of Two](#67-check-if-a-number-is-a-power-of-two) · [73 Check if a Number is a Perfect Square](#73-check-if-a-number-is-a-perfect-square) · [77 Check if a Number is a Prime Number](#77-check-if-a-number-is-a-prime-number) · [87 Check if a Number is a Fibonacci Number](#87-check-if-a-number-is-a-fibonacci-number) · [90 Check if a Number is Odd](#90-check-if-a-number-is-odd) · [104 Check for Repdigit](#104-check-for-repdigit) · [116 Find the Nth Fibonacci Number (recursive)](#116-find-the-nth-fibonacci-number-recursive) · [117 Symmetry Checker](#117-symmetry-checker) · [127 Check if a Number is a Neon Number](#127-check-if-a-number-is-a-neon-number) · [129 Check if a Number is a Disarium Number](#129-check-if-a-number-is-a-disarium-number) · [132 Check if a Number is a Pronic Number](#132-check-if-a-number-is-a-pronic-number) · [139 Check if a Number is a Prime Factor of Another Number](#139-check-if-a-number-is-a-prime-factor-of-another-number) · [140 Find the Largest Prime Factor of a Number](#140-find-the-largest-prime-factor-of-a-number) · [141 Check if a Number is a Pronic Square](#141-check-if-a-number-is-a-pronic-square) · [145 Check if a Number is a Happy Number](#145-check-if-a-number-is-a-happy-number) · [163 Find the Factors of a Number (excluding 1 and the number itself)](#163-find-the-factors-of-a-number-excluding-1-and-the-number-itself) · [173 Find the Nth Fibonacci Number](#173-find-the-nth-fibonacci-number) · [180 Check if a Number is a Vampire Number](#180-check-if-a-number-is-a-vampire-number) · [182 Check if a Number is a Duck Number](#182-check-if-a-number-is-a-duck-number) · [185 Check if a Number is a Kaprekar Number](#185-check-if-a-number-is-a-kaprekar-number) · [188 Sastry Number Checker](#188-sastry-number-checker) · [189 Factor Chain Checker](#189-factor-chain-checker) · [198 Check if a Number is a Leyland Number](#198-check-if-a-number-is-a-leyland-number) · [204 Check if a Number is a Pandigital Number](#204-check-if-a-number-is-a-pandigital-number) · [218 Check if a Number is a Reversible Number](#218-check-if-a-number-is-a-reversible-number) · [222 Find the Sum of Proper Divisors of a Number](#222-find-the-sum-of-proper-divisors-of-a-number) · [223 Check if a Number is a Unitary Perfect Number](#223-check-if-a-number-is-a-unitary-perfect-number) · [226 Check if a Number is a Harshad Smith Number](#226-check-if-a-number-is-a-harshad-smith-number) · [227 Check if a Number is a Perfect Power](#227-check-if-a-number-is-a-perfect-power) · [232 Check if a Number is a Wedderburn-Etherington Number](#232-check-if-a-number-is-a-wedderburn-etherington-number) · [236 Check if a Number is a Repunit Number](#236-check-if-a-number-is-a-repunit-number)
- **Geometry** (31): [23 Calculate the Area of a Circle](#23-calculate-the-area-of-a-circle) · [118 Maximum Triangle Edge Calculator](#118-maximum-triangle-edge-calculator) · [119 Calculate the Perimeter of a Rectangle](#119-calculate-the-perimeter-of-a-rectangle) · [135 Calculate the Hypotenuse of a Right-Angled Triangle](#135-calculate-the-hypotenuse-of-a-right-angled-triangle) · [147 Calculate the Volume of a Sphere](#147-calculate-the-volume-of-a-sphere) · [153 Find the Area of a Rectangle](#153-find-the-area-of-a-rectangle) · [156 Calculate the Volume of a Cylinder](#156-calculate-the-volume-of-a-cylinder) · [164 Calculate the Area of a Triangle given the Base and Height](#164-calculate-the-area-of-a-triangle-given-the-base-and-height) · [177 Calculate the Volume of a Cube](#177-calculate-the-volume-of-a-cube) · [179 Calculate the Perimeter of a Triangle](#179-calculate-the-perimeter-of-a-triangle) · [184 Calculate the Area of a Trapezoid](#184-calculate-the-area-of-a-trapezoid) · [186 Calculate the Volume of a Cone](#186-calculate-the-volume-of-a-cone) · [191 Calculate the Volume of a Cuboid](#191-calculate-the-volume-of-a-cuboid) · [194 Calculate the Area of a Circle Sector](#194-calculate-the-area-of-a-circle-sector) · [195 Calculate the Area of a Regular Polygon](#195-calculate-the-area-of-a-regular-polygon) · [197 Calculate the Area of an Ellipse](#197-calculate-the-area-of-an-ellipse) · [201 Calculate the Area of a Parallelogram](#201-calculate-the-area-of-a-parallelogram) · [215 Calculate the Area of a Regular Hexagon](#215-calculate-the-area-of-a-regular-hexagon) · [216 Calculate Cube Diagonal from Volume](#216-calculate-cube-diagonal-from-volume) · [219 Calculate the Circumference of a Circle](#219-calculate-the-circumference-of-a-circle) · [224 Calculate the Perimeter of a Regular Polygon](#224-calculate-the-perimeter-of-a-regular-polygon) · [225 Calculate the Area of an Equilateral Triangle](#225-calculate-the-area-of-an-equilateral-triangle) · [230 Calculate the Area of a Regular Pentagon](#230-calculate-the-area-of-a-regular-pentagon) · [231 Calculate the Volume of a Pyramid](#231-calculate-the-volume-of-a-pyramid) · [233 Calculate the Surface Area of a Cube](#233-calculate-the-surface-area-of-a-cube) · [235 Calculate the Area of a Regular Octagon](#235-calculate-the-area-of-a-regular-octagon) · [237 Calculate the Volume of an Ellipsoid](#237-calculate-the-volume-of-an-ellipsoid) · [251 Calculate The Volume of a Box](#251-calculate-the-volume-of-a-box) · [260 Calculate the Distance between Two Points in a 2D Plane](#260-calculate-the-distance-between-two-points-in-a-2d-plane) · [263 Calculate the Area of a Kite](#263-calculate-the-area-of-a-kite) · [264 Calculate the Area of a Sector](#264-calculate-the-area-of-a-sector)
- **Conversions** (14): [1 Convert Celsius to Fahrenheit](#1-convert-celsius-to-fahrenheit) · [3 Convert RGB to Hex](#3-convert-rgb-to-hex) · [37 Convert String to Number](#37-convert-string-to-number) · [50 Convert DNA to RNA](#50-convert-dna-to-rna) · [52 Convert an array to a comma-separated string](#52-convert-an-array-to-a-comma-separated-string) · [72 Convert Feet to Meters](#72-convert-feet-to-meters) · [79 Convert Degrees to Radians](#79-convert-degrees-to-radians) · [80 Binary Letter Converter](#80-binary-letter-converter) · [105 Convert Binary Number to Decimal](#105-convert-binary-number-to-decimal) · [152 Hacker Speak Converter](#152-hacker-speak-converter) · [158 Convert Decimal Number to Octal](#158-convert-decimal-number-to-octal) · [169 Convert Decimal Number to Hexadecimal](#169-convert-decimal-number-to-hexadecimal) · [203 Convert RGB to HSL (Hue, Saturation, Lightness)](#203-convert-rgb-to-hsl-hue-saturation-lightness) · [206 Convert Yen to USD](#206-convert-yen-to-usd)
- **Date & time** (21): [5 Check if Date is Valid](#5-check-if-date-is-valid) · [6 Find the Day of Year](#6-find-the-day-of-year) · [8 Find the Number of Days Between Two Days](#8-find-the-number-of-days-between-two-days) · [28 Convert Seconds to HH:MM:SS Format](#28-convert-seconds-to-hh-mm-ss-format) · [35 Get the Current Date in DD/MM/YYYY Format](#35-get-the-current-date-in-ddmmyyyy-format) · [41 Get the Current Year](#41-get-the-current-year) · [47 Convert Minutes to Seconds](#47-convert-minutes-to-seconds) · [53 Check if a Year is a Leap Year](#53-check-if-a-year-is-a-leap-year) · [55 Convert Minutes to Hours and Minutes](#55-convert-minutes-to-hours-and-minutes) · [59 Convert Video Length from Minutes to Seconds](#59-convert-video-length-from-minutes-to-seconds) · [60 Find the Difference between Two Dates in Days](#60-find-the-difference-between-two-dates-in-days) · [62 Convert Seconds to Minutes and Seconds](#62-convert-seconds-to-minutes-and-seconds) · [66 Get the Day of the Week from a Date](#66-get-the-day-of-the-week-from-a-date) · [70 Get the Month Name from a Date](#70-get-the-month-name-from-a-date) · [75 Get the Current Month (0-based index)](#75-get-the-current-month-0-based-index) · [76 Century from Year](#76-century-from-year) · [82 Convert Days to Years, Months, and Days](#82-convert-days-to-years-months-and-days) · [88 Convert Hours to Minutes](#88-convert-hours-to-minutes) · [97 Convert Seconds to Hours, Minutes, and Seconds](#97-convert-seconds-to-hours-minutes-and-seconds) · [101 Convert Video Length to Seconds](#101-convert-video-length-to-seconds) · [138 Convert Seconds to Days, Hours, Minutes, and Seconds](#138-convert-seconds-to-days-hours-minutes-and-seconds)
- **Validation & regex** (15): [61 Check if a String is a Valid Email Address](#61-check-if-a-string-is-a-valid-email-address) · [111 Validate Zip Code](#111-validate-zip-code) · [160 Check if a String is a Valid Phone Number (North American Format)](#160-check-if-a-string-is-a-valid-phone-number-north-american-format) · [165 Check if a String is a Valid Social Security Number (SSN)](#165-check-if-a-string-is-a-valid-social-security-number-ssn) · [168 Check if a String is a Valid IPv4 Address](#168-check-if-a-string-is-a-valid-ipv4-address) · [170 Check if a String is a Valid Date (YYYY-MM-DD Format)](#170-check-if-a-string-is-a-valid-date-yyyy-mm-dd-format) · [172 Check if a String is a Valid Password](#172-check-if-a-string-is-a-valid-password) · [178 Check if a String is a Valid Credit Card Number (Visa, MasterCard, Discover, American Express)](#178-check-if-a-string-is-a-valid-credit-card-number-visa-mastercard-discover-american-express) · [187 Check if a String is a Valid US Phone Number](#187-check-if-a-string-is-a-valid-us-phone-number) · [200 Check if a String is a Valid IPv6 Address](#200-check-if-a-string-is-a-valid-ipv6-address) · [202 Check if a String is a Valid MAC Address](#202-check-if-a-string-is-a-valid-mac-address) · [238 Check if a String is a Valid URL](#238-check-if-a-string-is-a-valid-url) · [239 Check if a String is a Valid Tax Identification Number (TIN)](#239-check-if-a-string-is-a-valid-tax-identification-number-tin) · [240 Check if a String is a Valid ISBN (International Standard Book Number)](#240-check-if-a-string-is-a-valid-isbn-international-standard-book-number) · [241 Check if a String is a Valid IP Address](#241-check-if-a-string-is-a-valid-ip-address)
- **Random generation** (12): [10 Generate Random Hex](#10-generate-random-hex) · [11 Create Random Strings](#11-create-random-strings) · [19 Shuffle an Array](#19-shuffle-an-array) · [27 Generate a Random Number within a Range](#27-generate-a-random-number-within-a-range) · [42 Generate a Random Number between 1 and 10](#42-generate-a-random-number-between-1-and-10) · [95 Generate an Array of Random Numbers](#95-generate-an-array-of-random-numbers) · [115 Shuffle the Characters of a String](#115-shuffle-the-characters-of-a-string) · [166 Generate an Array of Random Numbers within a Range](#166-generate-an-array-of-random-numbers-within-a-range) · [183 Generate a Random Password](#183-generate-a-random-password) · [193 Generate a Random Color (Hexadecimal Format)](#193-generate-a-random-color-hexadecimal-format) · [199 Generate a Random UUID](#199-generate-a-random-uuid) · [214 Generate a Random Alphanumeric String](#214-generate-a-random-alphanumeric-string)
- **Puzzles & fun** (21): [2 Swap Two Variables](#2-swap-two-variables) · [12 Find the Odd Occurrence](#12-find-the-odd-occurrence) · [15 Pyramid Pattern](#15-pyramid-pattern) · [18 Matchstick Count in Steps](#18-matchstick-count-in-steps) · [38 Marathon Distance Checker](#38-marathon-distance-checker) · [83 Check if an Object is Empty](#83-check-if-an-object-is-empty) · [84 Count Decimal Places](#84-count-decimal-places) · [96 Join Path Portions](#96-join-path-portions) · [113 Maurice's Racing Snails](#113-maurices-racing-snails) · [121 Greeting Function with Conditional Message](#121-greeting-function-with-conditional-message) · [128 Recursive Right Shift Mimicker](#128-recursive-right-shift-mimicker) · [143 Loaded Die Detection](#143-loaded-die-detection) · [146 Billable Days Bonus Calculator](#146-billable-days-bonus-calculator) · [155 Missing Number Finder](#155-missing-number-finder) · [157 BBQ Skewer Analyzer](#157-bbq-skewer-analyzer) · [171 Chinese Zodiac Sign Identifier](#171-chinese-zodiac-sign-identifier) · [174 Diving Minigame Checker](#174-diving-minigame-checker) · [209 Determine Rock, Paper, Scissors Winner](#209-determine-rock-paper-scissors-winner) · [211 Update Ages After Years](#211-update-ages-after-years) · [212 Detect Syncopation in Music](#212-detect-syncopation-in-music) · [256 Chatroom Status](#256-chatroom-status)

## Entries 1–50

### 1. Convert Celsius to Fahrenheit

The celsius_to_fahrenheit function converts Celsius to Fahrenheit.

```python
def celsius_to_fahrenheit(celsius): return (celsius * 9/5) + 32
print(celsius_to_fahrenheit(25))
# Output: 77.0
```

```text
77.0
```


### 2. Swap Two Variables

The swap_without_temp function swaps the values of two variables a and b without using a temporary variable.

```python
def swap_without_temp(a, b):
    return b, a
a, b = swap_without_temp(5, 10)
print(f"After swapping: a = {a}, b = {b}")
# Output: After swapping: a = 10, b = 5
```

```text
After swapping: a = 10, b = 5
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: The `print` swaps the labels. The real output is `a = 5, b = 10`; the book shows `a = 10, b = 5`.
>
> Original book code (do not use):
>
> ```python
> def swap_without_temp(a, b):
>     return b, a
> result = swap_without_temp(5, 10)
> print(f"After swapping: a = {result[1]}, b = {result[0]}")
> # Output: After swapping: a = 10, b = 5
> ```


### 3. Convert RGB to Hex

The rgb_to_hex function combines the red, green, and blue (RGB) values into a single hexadecimal color code.

```python
def rgb_to_hex(r, g, b): return f"#{((r << 16) + (g << 8) + b):06X}"
print(rgb_to_hex(0, 51, 255))
# Output: #0033FF
```

```text
#0033FF
```


### 4. Transpose of a Matrix

The transpose_matrix function computes the transpose of a given matrix.

```python
def transpose_matrix(matrix):
    return [list(row) for row in zip(*matrix)]
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]
print("\n".join(", ".join(map(str, row)) for row in transpose_matrix(matrix)))
# Output:
#   1, 4, 7
#   2, 5, 8
#   3, 6, 9
```

```text
1, 4, 7
2, 5, 8
3, 6, 9
```


### 5. Check if Date is Valid

The is_date_valid function checks if a date is valid.

```python
from datetime import datetime
def is_date_valid(val): return datetime.strptime(val, "%B %d, %Y %H:%M:%S") if val else False
print(is_date_valid("December 17, 1995 03:24:00"))
# Output: 1995-12-17 03:24:00
```

```text
1995-12-17 03:24:00
```


### 6. Find the Day of Year

The day_of_year function takes a date as input and calculates the day of the year for that date.

```python
from datetime import datetime
def day_of_year(date): return date.timetuple().tm_yday
print(day_of_year(datetime(2024, 10, 1)))
# Output: 275
```

```text
275
```


### 7. Capitalize a String

The capitalize_string function takes a string as input and capitalizes the first character.

```python
def capitalize_string(s): return s[0].upper() + s[1:] if s else ""
print(capitalize_string("follow for more"))
# Output: Follow for more
```

```text
Follow for more
```


### 8. Find the Number of Days Between Two Days

The day_diff function finds the number of days between two days.

```python
from datetime import datetime
def day_diff(date1, date2): return abs((date2 - date1).days) + 1
date1 = datetime(2020, 10, 21)
date2 = datetime(2021, 10, 22)
print(day_diff(date1, date2))
# Output: 367
```

```text
367
```


### 9. Find the Frecuency of Character in a String

The character_frequency function finds the frequency of characters in a String.

```python
from collections import Counter
def character_frequency(string): return dict(Counter(string))  # keeps first-seen order
print(", ".join([f"{k}=>{v}" for k, v in character_frequency("hello").items()]))
# Output: h=>1, e=>1, l=>2, o=>1
```

```text
h=>1, e=>1, l=>2, o=>1
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `set()` iteration order is arbitrary, so the order of the printed pairs varies between runs. Use `collections.Counter(s)` to keep first-seen order.
>
> Original book code (do not use):
>
> ```python
> def character_frequency(string): return {char: string.count(char) for char in set(string)}
> print(", ".join([f"{k}=>{v}" for k, v in character_frequency("hello").items()]))
> # Output: h=>1, e=>1, l=>2, o=>1
> ```


### 10. Generate Random Hex

The random_hex function generates a random integer between 0 and 16777215 (0xffffff in hexadecimal).

<!-- nondeterministic -->
```python
import random
def random_hex(): return f"#{random.randint(0, 0xFFFFFF):06X}"
print(random_hex())
# Output (varies), e.g.: #C53EDF
```

```text
#C53EDF
```


### 11. Create Random Strings

The random_string function generates a random String of lowercase letters with the specified length.

<!-- nondeterministic -->
```python
import random
import string
def random_string(length): return ''.join(random.choice(string.ascii_lowercase) for _ in range(length))
print(random_string(10))
# Output (varies), e.g.: mynbiqpmzj
```

```text
mynbiqpmzj
```


### 12. Find the Odd Occurrence

The find_odd function finds the integer which appears an odd number of times in a given list of integers.

```python
import functools
def find_odd(ar):
    return functools.reduce(lambda x, y: x ^ y, ar)
ar = [4, 7, 4, 9, 7, 9, 9]  # only 9 occurs an odd number of times
print("Input:", " ".join(map(str, ar)))
# Output: Input: 4 7 4 9 7 9 9
print("Result:", find_odd(ar))
# Output: Result: 9
```

```text
Input: 4 7 4 9 7 9 9
Result: 9
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: XOR-reduce only finds the odd-one-out when **exactly one** value occurs an odd number of times. The book feeds it random numbers, so `121` is just the XOR of that sample and has no meaning.
>
> Original book code (do not use):
>
> ```python
> import random
> import functools
> def find_odd(ar):
>     return functools.reduce(lambda x, y: x ^ y, ar)
> ar = [random.randint(1, 100) for _ in range(random.randint(10, 20))]
> print("Input:", " ".join(map(str, ar)))
> print("Result:", find_odd(ar))
> # Input: 25 32 37 63 66 6 4 26 2 38 59 1 30
> # Result: 121
> ```


### 13. Check if a Number is Even or Odd

The is_even function checks whether a given number is even or odd.

```python
def is_even(num): return num % 2 == 0
print(is_even(2))
# Output: True
```

```text
True
```


### 14. Simple Sum

The addition function takes two numbers as input and returns their sum.

```python
def addition(a, b): return a + b
result = addition(5, 3)
print(result)
# Output: 8
```

```text
8
```


### 15. Pyramid Pattern

The create_pyramid function takes the number of rows as an argument and returns an array representing the pyramid pattern.

```python
def create_pyramid(rows):
    return [f"{' ' * (rows - i)}{'*' * (2 * i - 1)}" for i in range(1, rows + 1)]
pyramid = create_pyramid(5)
for row in pyramid:
    print(row)
# Output:
#       *
#      ***
#     *****
#    *******
#   *********
```

```text
    *
   ***
  *****
 *******
*********
```


### 16. Reverse a String

The reverse function takes a string as input and returns a new string with the characters in reverse order.

```python
def reverse(string): return string[::-1]
print(reverse("hello world"))
# Output: dlrow olleh
```

```text
dlrow olleh
```


### 17. Check If Array is Empty

The is_not_empty function checks if an array is not empty.

```python
def is_not_empty(arr): return isinstance(arr, list) and len(arr) > 0
print(is_not_empty([1, 2, 3]))
# Output: True
```

```text
True
```


### 18. Matchstick Count in Steps

The match_houses function calculates the total number of matchsticks required based on the number of steps provided.

```python
def match_houses(steps): return steps * 6 - (steps - 1) if steps > 0 else 0
print(match_houses(1))
# Output: 6
print(match_houses(4))
# Output: 21
print(match_houses(0))
# Output: 0
```

```text
6
21
0
```


### 19. Shuffle an Array

The shuffle_array function randomly shuffles the elements of a given array.

<!-- nondeterministic -->
```python
import random
def shuffle_array(arr):
    shuffled = arr[:]
    random.shuffle(shuffled)
    return shuffled
print(", ".join(map(str, shuffle_array([1, 2, 3, 4]))))
# Output (varies), e.g.: 3, 1, 2, 4
```

```text
3, 1, 2, 4
```


### 20. Validate Vowel Sandwich

The is_vowel_sandwich function validates whether a 3-character string is a vowel sandwich.

```python
def is_vowel_sandwich(string): return len(string) == 3 and string[0] not in 'aeiou' and string[1] in 'aeiou' and string[2] not in 'aeiou'
print(is_vowel_sandwich("bat"))
# Output: True
print(is_vowel_sandwich("cat"))
# Output: True
print(is_vowel_sandwich("dog"))
# Output: True
```

```text
True
True
True
```

> [!NOTE]
> **Output comment corrected.** `bat` and `dog` are both consonant-vowel-consonant, so the code returns `True` for them. The book claims `False`.


### 21. Count True Values in Boolean Array

The count_true function counts the number of true values in a boolean array.

```python
def count_true(lst): return sum(1 for x in lst if x)
bool_array = [True, False, True, False, True]
count = count_true(bool_array)
print("Number of true values:", count)
# Output: Number of true values: 3
```

```text
Number of true values: 3
```


### 22. Get the Length of a String

The get_length function returns the number of characters in the given string.

```python
def get_length(string): return len(string)
print(get_length("Hello, world!"))
# Output: 13
```

```text
13
```


### 23. Calculate the Area of a Circle

The calculate_circle_area function calculates the area of a circle given its radius.

```python
import math
def calculate_circle_area(radius): return math.pi * radius ** 2
print(calculate_circle_area(5))
# Output: 78.53981633974483
```

```text
78.53981633974483
```


### 24. Move Capital Letters to Front

The cap_to_front function moves all capital letters in a word to the front of the word, preserving their original order, and followed by the lowercase letters.

```python
def cap_to_front(s): return ''.join(filter(str.isupper, s)) + ''.join(filter(str.islower, s))
print(cap_to_front("MoveCapitalLettersToFront"))
# Output: MCLTFoveapitalettersoront
```

```text
MCLTFoveapitalettersoront
```

> [!NOTE]
> **Output comment corrected.** The real output is `MCLTFoveapitalettersoront`. The book drops the `T`.


### 25. Check if an Array is Special

The is_special_array function determines whether an array is special, where every even index contains an even number and every odd index contains an odd number.

```python
def is_special_array(arr): return all(arr[i] % 2 == i % 2 for i in range(len(arr)))
arr = [2, 3, 6, 8, 9]
print(is_special_array(arr))
# Output: False
```

```text
False
```


### 26. Validate Number Within Bounds

The int_within_bounds function validates whether a number n is exclusively within the bounds of lower and upper.

```python
def int_within_bounds(n, lower, upper): return lower < n < upper and n % 1 == 0
print(int_within_bounds(10, 5, 20))
# Output: True
print(int_within_bounds(5, 5, 20))
# Output: False
print(int_within_bounds(21, 5, 20))
# Output: False
```

```text
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: The description says *exclusively* within bounds, but `lower <= n` makes the lower bound inclusive, so `(5, 5, 20)` returns `True` (book: `False`).
>
> Original book code (do not use):
>
> ```python
> def int_within_bounds(n, lower, upper): return lower <= n < upper and n % 1 == 0
> print(int_within_bounds(10, 5, 20))
> # Output: True
> print(int_within_bounds(5, 5, 20))
> # Output: False
> print(int_within_bounds(21, 5, 20))
> # Output: False
> ```


### 27. Generate a Random Number within a Range

The random_in_range function generates a random number within the specified range.

<!-- nondeterministic -->
```python
import random
def random_in_range(min_val, max_val): return random.randint(min_val, max_val)
print(random_in_range(1, 10))
# Output (varies), e.g.: 7
```

```text
7
```


### 28. Convert Seconds to HH-MM-SS Format

The seconds_to_hhmmss function converts the given number of seconds into the HH:MM:SS format.

```python
def seconds_to_hhmmss(seconds):
    hours = seconds // 3600
    minutes = (seconds % 3600) // 60
    seconds = seconds % 60
    return f"{hours:02}:{minutes:02}:{seconds:02}"
print(seconds_to_hhmmss(3660))
# Output: 01:01:00
```

```text
01:01:00
```


### 29. Get the Last Element of an Array

The get_last_element function retrieves the last element of the given array.

```python
def get_last_element(arr): return arr[-1]
print(get_last_element([1, 2, 3, 4]))
# Output: 4
```

```text
4
```


### 30. Jazzify Chords

The jazzified_arr function appends the number 7 to the end of every chord in an array. It ignores all chords that already end with 7.

```python
def jazzify(arr): return [c if c.endswith("7") else c + "7" for c in arr]
arr = ["G", "F", "C", "E7", "Dm"]
jazzified_arr = jazzify(arr)
print(", ".join(jazzified_arr))
# Output: G7, F7, C7, E7, Dm7
```

```text
G7, F7, C7, E7, Dm7
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: It adds the *number* 7 (`1 -> 8`) instead of appending `"7"` to a chord name (`"C" -> "C7"`).
>
> Original book code (do not use):
>
> ```python
> def jazzify(arr): return [x if str(x)[-1] == '7' else x + 7 for x in arr]
> arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
> jazzified_arr = jazzify(arr)
> print(", ".join(map(str, jazzified_arr)))
> # Output: 8, 9, 10, 11, 12, 13, 7, 15, 16
> ```


### 31. Check if All Elements in an Array are the Same

The test_jackpot function takes in a string representing the result of a jackpot game and returns true if all elements in the string are the same, indicating a jackpot, and false otherwise.

```python
def test_jackpot(result): return len(set(result)) == 1
result = "22222"
print(test_jackpot(result))
# Output: True
```

```text
True
```


### 32. Sum of Numbers up to a Given Number

The add_up function calculates the sum of all numbers from 1 to the number passed to the function in C#.

```python
def add_up(num): return num * (num + 1) // 2
print(add_up(5))
# Output: 15
```

```text
15
```


### 33. Sum all Numbers in an Array

The sum_array function calculates the sum of all numbers in a given array.

```python
def sum_array(arr): return sum(arr)
print(sum_array([1, 2, 3, 4, 5]))
# Output: 15
```

```text
15
```


### 34. Find the Maximum Value in an Array

The find_max function finds the maximum value in a given array.

```python
def find_max(arr): return max(arr)
print(find_max([10, 5, 8, 20, 3]))
# Output: 20
```

```text
20
```


### 35. Get the Current Date in DD/MM/YYYY Format

The get_current_date function returns the current date in the format "DD/MM/YYYY".

<!-- nondeterministic -->
```python
from datetime import datetime
def get_current_date(): return datetime.now().strftime("%d/%m/%Y")
print(get_current_date())
# Output (varies), e.g.: 01/10/2026
```

```text
01/10/2026
```


### 36. Calculate the Power of a Number

The power function calculates the power of a given base raised to the specified exponent.

```python
def power(base, exponent): return base ** exponent
print(power(2, 5))
# Output: 32
```

```text
32
```

> [!NOTE]
> **Output comment corrected.** `2 ** 5` is an `int`, so it prints `32`, not `32.0`.


### 37. Convert String to Number

The string_to_number function converts a string to a floating-point number.

```python
def string_to_number(string): return float(string)
print(string_to_number("3.14"))
# Output: 3.14
```

```text
3.14
```


### 38. Marathon Distance Checker

The marathon_distance function helps Mary determine if the marathon she wants to run is exactly 25 miles long by analyzing the lengths listed in small portions on the sign-up sheet. It returns true if the total distance matches 25 miles, otherwise, it returns false.

```python
def marathon_distance(distances): return sum(map(abs, distances)) == 25
distances = [1, 2, -3, 4, 5, -6, 7, 8, -9, 10]
print(marathon_distance(distances))
# Output: False
```

```text
False
```


### 39. Count the Number of Words in a String

The count_words function counts the number of words in a given string.

```python
def count_words(string): return len(string.split())
print(count_words("Hello world, how are you?"))
# Output: 5
```

```text
5
```


### 40. Count Ones in Binary Representation

The count_ones function counts the number of ones in the binary representation of an integer.

```python
def count_ones(n): return bin(n).count('1')
result = count_ones(12)
print(result)
# Output: 2
```

```text
2
```


### 41. Get the Current Year

The current_year function returns the current year as an integer.

<!-- nondeterministic -->
```python
from datetime import datetime
def current_year(): return datetime.now().year
print(current_year())
# Output (varies), e.g.: 2026
```

```text
2026
```


### 42. Generate a Random Number between 1 and 10

The random_1_to_10 function generates a random integer between 1 and 10 (inclusive) using the rand method with a range of 1 to 10.

<!-- nondeterministic -->
```python
import random
def random_1_to_10(): return random.randint(1, 10)
print(random_1_to_10())
# Output (varies), e.g.: 7
```

```text
7
```


### 43. Check if a String is Empty

The empty_string function checks if a string is empty.

```python
def empty_string(string): return not string.strip()
print(empty_string(""))
# Output: True
print(empty_string("Hello, world!"))
# Output: False
```

```text
True
False
```


### 44. Sum of Index Multiplied Elements

The index_multiplier function calculates the sum of all items in an array, where each item is multiplied by its index (zero- based). If the array is empty, it returns 0.

```python
def index_multiplier(arr): return sum(value * index for index, value in enumerate(arr))
arr = [1, 2, 3, 4, 5]
print(index_multiplier(arr))
# Output: 40
```

```text
40
```


### 45. Calculate Progress Days

The progress_days function calculates the total number of progress days based on an array of miles run every Saturday.

```python
def progress_days(runs): return sum(runs[i] < runs[i + 1] for i in range(len(runs) - 1))
runs = [3, 4, 1, 2, 4, 5]
print(progress_days(runs))
# Output: 4
```

```text
4
```

> [!NOTE]
> **Output comment corrected.** Returns `4`, not `3`: the increases are 3<4, 1<2, 2<4 and 4<5.


### 46. Check if a Number is a Multiple of 5

The is_multiple_of_5 function checks if a given number is a multiple of 5.

```python
def is_multiple_of_5(num): return num % 5 == 0
print(is_multiple_of_5(10))
# Output: True
print(is_multiple_of_5(7))
# Output: False
```

```text
True
False
```


### 47. Convert Minutes to Seconds

The mins_to_secs convert minutes to seconds. It takes a number representing minutes (mins) as input and returns the equivalent number of seconds by multiplying the number of minutes by 60.

```python
def mins_to_secs(mins): return mins * 60
print(mins_to_secs(5))
# Output: 300
```

```text
300
```


### 48. Find the Maximum Value in an Array of Objects

The FindMaxValue function finds the maximum value in an array of objects.

```python
def find_max_value(arr, key):
    return max(item[key] for item in arr)
# Example usage
arr = [
    {"name": "Alice", "score": 80},
    {"name": "Bob", "score": 95},
    {"name": "Charlie", "score": 70}
]
print(find_max_value(arr, "score"))
# Output: 95
```

```text
95
```


### 49. Check if a String starts with a specific character

The starts_with_char function checks if a given string starts with a specific character.

```python
def starts_with_char(string, char):
    return string.lower().startswith(char.lower())
print(starts_with_char("Hello, world!", 'H'))
# Output: True
print(starts_with_char("Hello, world!", 'h'))
# Output: True
```

```text
True
True
```


### 50. Convert DNA to RNA

The dna_to_rna function takes a DNA sequence as input and converts it into its corresponding RNA sequence.

```python
def dna_to_rna(dna):
    # coding (sense) strand -> mRNA: same sequence with T replaced by U
    return dna.upper().replace("T", "U")
print(dna_to_rna("ATTGC"))
# Output: AUUGC
```

```text
AUUGC
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: **Biology error.** The map `A->U, T->A, C->G, G->C` is the complement transcribed from the *template* strand, read 3'->5' without reversing. Conventional DNA->RNA from the coding strand is just `T -> U`. The book's own output is also wrong: the code turns `ATTGC` into `UAACG`, not `UAAAC`.
>
> Original book code (do not use):
>
> ```python
> def dna_to_rna(dna):
>     conversion = {'A': 'U', 'T': 'A', 'C': 'G', 'G': 'C'}
>     return ''.join(conversion.get(base, '') for base in dna)
> print(dna_to_rna("ATTGC"))
> # Output: UAAAC
> ```


## Entries 51–100

### 51. Check if an array contains a specific value

The contains_value function checks if a given array contains a specific value.

```python
def contains_value(arr, value):
    return value in arr
# Example usage
print(contains_value([1, 2, 3, 4, 5], 3))
# Output: True
print(contains_value([1, 2, 3, 4, 5], 6))
# Output: False
```

```text
True
False
```


### 52. Convert an array to a comma-separated string

The array_to_csv function converts an array to a comma-separated string.

```python
def array_to_csv(arr):
    return ', '.join(map(str, arr))
# Example usage
print(array_to_csv([1, 2, 3, 4, 5]))
# Output: 1, 2, 3, 4, 5
```

```text
1, 2, 3, 4, 5
```


### 53. Check if a Year is a Leap Year

The is_leap_year function takes a year as input and returns true if it's a leap year and false otherwise.

```python
def is_leap_year(year):
    return (year % 4 == 0 and year % 100 != 0) or year % 400 == 0
# Example usage
print(is_leap_year(2024))
# Output: True
print(is_leap_year(2023))
# Output: False
```

```text
True
False
```


### 54. Find the Index of an Element in an Array

The find_index function finds the index of an element in an array.

```python
def find_index(arr, element):
    try:
        return arr.index(element)
    except ValueError:
        return -1
# Example usage
fruits = ["apple", "banana", "orange", "grape"]
print(find_index(fruits, "orange"))
# Output: 2
```

```text
2
```


### 55. Convert Minutes to Hours and Minutes

The mins_to_hours_and_mins function convert minutes to hours and minutes.

```python
def mins_to_hours_and_mins(mins):
    return f"{mins // 60} hours and {mins % 60} minutes"
# Example usage
print(mins_to_hours_and_mins(150))
# Output: 2 hours and 30 minutes
```

```text
2 hours and 30 minutes
```


### 56. Check if an Array is Sorted in Ascending Order

The is_sorted_ascending function takes an array arr as input and checks if every element in the array is greater than or equal to the previous element, ensuring that the array is sorted in ascending order.

```python
def is_sorted_ascending(arr):
    return all(arr[i] <= arr[i + 1] for i in range(len(arr) - 1))
# Example usage
print(is_sorted_ascending([1, 2, 3, 5, 8]))
# Output: True
print(is_sorted_ascending([1, 5, 3, 8, 2]))
# Output: False
```

```text
True
False
```


### 57. Remove a Specific Element from an Array

The remove_element function removes a specific element from an array.

```python
def remove_element(arr, element):
    return [x for x in arr if x != element]
# Example usage
result = remove_element([1, 2, 3, 4, 5], 3)
print(result)
# Output: [1, 2, 4, 5]
```

```text
[1, 2, 4, 5]
```


### 58. Truncate a String to a Given Length

The truncate_string function truncate a string to a given length.

```python
def truncate_string(s, max_length):
    return s[:max_length] + '...' if len(s) > max_length else s
# Example usage
print(truncate_string("Hello, world!", 5))
# Output: Hello...
```

```text
Hello...
```


### 59. Convert Video Length from Minutes to Seconds

The minutes_to_seconds function takes the length of a video in the format "mm:ss" and converts it into seconds.

```python
def minutes_to_seconds(time):
    return sum(int(x) * 60 ** i for i, x in enumerate(reversed(time.split(':'))))
# Example usage
print(minutes_to_seconds("02:54"))
# Output: 174
```

```text
174
```


### 60. Find the Difference between Two Dates in Days

The DateDifferenceInDays function finds the difference between two dates in days.

```python
from datetime import datetime
def DateDifferenceInDays(date1, date2):
    return (date2 - date1).days
# Example usage
startDate = datetime(2023, 8, 1)
endDate = datetime(2023, 8, 10)
print(DateDifferenceInDays(startDate, endDate))
# Output: 9
```

```text
9
```


### 61. Check if a String is a Valid Email Address

The IsValidEmail function returns true if the email string matches the pattern, and false otherwise.

```python
import re
def IsValidEmail(email):
    return bool(re.match(r'^[^\s@]+@[^\s@]+\.[^\s@]+$', email))
# Example usage
print(IsValidEmail("user@example.com"))
# Output: True
print(IsValidEmail("invalid-email"))
# Output: False
```

```text
True
False
```


### 62. Convert Seconds to Minutes and Seconds

The SecsToMinsAndSecs function calculate the number of minutes and remaining seconds and then returns a formatted string containing the result.

```python
def SecsToMinsAndSecs(seconds):
    return f"{seconds // 60} minutes and {seconds % 60} seconds"
# Example usage
print(SecsToMinsAndSecs(120))
# Output: 2 minutes and 0 seconds
```

```text
2 minutes and 0 seconds
```


### 63. Generate a Fibonacci Sequence

The Fibonacci generates a Fibonacci sequence.

```python
def Fibonacci(n):
    return n if n <= 1 else Fibonacci(n - 1) + Fibonacci(n - 2)
# Example usage
fibonacci_sequence = [Fibonacci(i) for i in range(8)]
print(', '.join(map(str, fibonacci_sequence)))
# Output: 0, 1, 1, 2, 3, 5, 8, 13
```

```text
0, 1, 1, 2, 3, 5, 8, 13
```


### 64. Spell Out a Word

The Spelling function takes a word as input and spells it out by consecutively adding letters until the full word is completed. It then returns an array containing each step of the spelling process.

```python
def Spelling(word):
    return [word[:i+1] for i in range(len(word))]
# Example usage
word = "example"
spelled_word = Spelling(word)
print(", ".join(spelled_word))
# Output: e, ex, exa, exam, examp, exampl, example
```

```text
e, ex, exa, exam, examp, exampl, example
```


### 65. Check if an Array contains only Unique Values

The HasUniqueValues function converts the array arr to a set using uniq, which removes duplicate elements.

```python
def HasUniqueValues(arr):
    return len(set(arr)) == len(arr)
# Example usage
print(HasUniqueValues([1, 2, 3, 4, 5]))
# Output: True
print(HasUniqueValues([1, 2, 3, 4, 4]))
# Output: False
```

```text
True
False
```


### 66. Get the Day of the Week from a Date

The GetDayOfWeek function get the day of the week from a date.

```python
from datetime import datetime
def GetDayOfWeek(date_str):
    date_obj = datetime.strptime(date_str, '%Y-%m-%d')
    return date_obj.strftime('%A')
# Example usage
print(GetDayOfWeek("2023-08-02"))
# Output: Wednesday
```

```text
Wednesday
```


### 67. Check if a Number is a Power of Two

The IsPowerOfTwo function checks whether a given number is a power of two using bitwise operations.

```python
def IsPowerOfTwo(num):
    return num > 0 and num & (num - 1) == 0
# Example usage
print(IsPowerOfTwo(16))
# Output: True
print(IsPowerOfTwo(5))
# Output: False
print(IsPowerOfTwo(0))
# Output: False
```

```text
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `0 & -1 == 0`, so `IsPowerOfTwo(0)` returns `True`. Guard with `num > 0`.
>
> Original book code (do not use):
>
> ```python
> def IsPowerOfTwo(num):
>     return num & (num - 1) == 0
> # Example usage
> print(IsPowerOfTwo(16))
> # Output: True (16 is 2^4)
> print(IsPowerOfTwo(5))
> # Output: False
> ```


### 68. Generate multiplication table

The GenerateMultiplicationTable function creates a multiplication table of a specified size.

```python
def GenerateMultiplicationTable(size):
    table = [[(row + 1) * (col + 1) for col in range(size)] for row in range(size)]
    return table
# Example usage
size = 5
multiplicationTable = GenerateMultiplicationTable(size)
for row in multiplicationTable:
    print(", ".join(map(str, row)))
# Output:
#   1, 2, 3, 4, 5
#   2, 4, 6, 8, 10
#   3, 6, 9, 12, 15
#   4, 8, 12, 16, 20
#   5, 10, 15, 20, 25
```

```text
1, 2, 3, 4, 5
2, 4, 6, 8, 10
3, 6, 9, 12, 15
4, 8, 12, 16, 20
5, 10, 15, 20, 25
```


### 69. Shhh Whisperer

The Shhh function takes a sentence as input, removes all capital letters except for the first letter, wraps the sentence in double quotation marks, and adds ", whispered your friend." to the end.

```python
def Shhh(sentence):
    return f'"{sentence.capitalize()}", whispered your friend.'
# Example usage
print(Shhh("HELLO THERE"))
# Output: "Hello there", whispered your friend.
```

```text
"Hello there", whispered your friend.
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: It inserts a space and lowercases the first letter, printing `"h ello there", whispered your friend.`
>
> Original book code (do not use):
>
> ```python
> def Shhh(sentence):
>     lowered = f'"{sentence[0].lower()} {sentence[1:].lower()}", whispered your friend.'
>     return lowered
> # Example usage
> print(Shhh("HELLO THERE"))
> # Output: "Hello there", whispered your friend.
> ```


### 70. Get the Month Name from a Date

The GetMonthName function retrieves the name of the month from a given date.

```python
import datetime
def GetMonthName(date):
    return date.strftime("%B")
# Example usage
date = datetime.datetime(2023, 8, 2)
print(GetMonthName(date))
# Output: August
```

```text
August
```


### 71. Find the Bomb

The Bomb function searches for the word "bomb" in a given string. If the word is found, it returns "Duck!!!", indicating a potential danger. Otherwise, it returns "There is no bomb, relax.", reassuring that there is no threat.

```python
import re
def Bomb(s):
    return "Duck!!!" if re.search(r'\bbomb\b', s, re.IGNORECASE) else "There is no bomb, relax."
# Example usage
s = "The bomb is about to explode."
print(Bomb(s))
# Output: Duck!!!
```

```text
Duck!!!
```


### 72. Convert Feet to Meters

The FeetToMeters function converts a given length from feet to meters.

```python
def FeetToMeters(feet):
    return feet * 0.3048
# Example usage
print(FeetToMeters(10))
# Output: 3.048
```

```text
3.048
```


### 73. Check if a Number is a Perfect Square

The IsPerfectSquare function checks if a given number is a perfect square.

```python
def IsPerfectSquare(num):
    sqrt = num ** 0.5
    return sqrt.is_integer()
# Example usage
print(IsPerfectSquare(16))
# Output: True
print(IsPerfectSquare(10))
# Output: False
```

```text
True
False
```


### 74. Check if a String contains only Numbers

The ContainsOnlyNumbers function checks if a given string contains only numeric characters.

```python
import re
def ContainsOnlyNumbers(s):
    return bool(re.match(r'^\d+$', s))
# Example usage
print(ContainsOnlyNumbers("12345"))
# Output: True
print(ContainsOnlyNumbers("12a34"))
# Output: False
```

```text
True
False
```


### 75. Get the Current Month (0-based index)

The CurrentMonth retrieves the current month as a 0-based index.

<!-- nondeterministic -->
```python
from datetime import datetime
def CurrentMonth():
    return datetime.now().month - 1
# Example usage
print(CurrentMonth())
# Output (varies), e.g.: 9
```

```text
9
```


### 76. Century from Year

The CenturyFromYear function calculates the century corresponding to a given year. It takes a year as input and returns its corresponding century.

```python
def CenturyFromYear(year):
    return (year + 99) // 100
# Example usage
print(CenturyFromYear(1905))
# Output: 20
print(CenturyFromYear(1700))
# Output: 17
print(CenturyFromYear(1988))
# Output: 20
print(CenturyFromYear(2000))
# Output: 20
print(CenturyFromYear(2001))
# Output: 21
```

```text
20
17
20
20
21
```


### 77. Check if a Number is a Prime Number

The IsPrime function checks if a given number is prime.

```python
def IsPrime(num):
    return num > 1 and all(num % i != 0 for i in range(2, int(num ** 0.5) + 1))
# Example usage
print(IsPrime(13))
# Output: True
print(IsPrime(4))
# Output: False
```

```text
True
False
```


### 78. Get the Last N Elements of an Array

The LastNElements function retrieves the last n elements of an array.

```python
def LastNElements(arr, n):
    return arr[-n:]
# Example usage
result = LastNElements([1, 2, 3, 4, 5], 3)
print(", ".join(map(str, result)))
# Output: 3, 4, 5
```

```text
3, 4, 5
```


### 79. Convert Degrees to Radians

The DegToRad function converts an angle in degrees to radians.

```python
import math
def DegToRad(degrees):
    return degrees * (math.pi / 180)
# Example usage
print(DegToRad(90))
# Output: 1.5707963267948966
```

```text
1.5707963267948966
```


### 80. Binary Letter Converter

The ConvertBinary function transforms all letters from 'a' to 'm' to 0 and letters from 'n' to 'z' to 1 in a given string.

```python
def ConvertBinary(s):
    return ''.join(['0' if 'a' <= c <= 'm' else '1' for c in s.lower()])
# Example usage
print(ConvertBinary("hello"))
# Output: 00001
print(ConvertBinary("world"))
# Output: 11100
print(ConvertBinary("abcxyz"))
# Output: 000111
```

```text
00001
11100
000111
```

> [!NOTE]
> **Output comment corrected.** `o`, `r` and `w` come after `m`, so `hello -> 00001` and `world -> 11100`. The book shows `00000` / `11111`.


### 81. Find the Intersection of Two Arrays

The FindIntersection function finds the intersection of two arrays.

```python
def FindIntersection(arr1, arr2):
    return list(set(arr1) & set(arr2))
# Example usage
arr1 = [1, 2, 3]
arr2 = [2, 3, 4]
intersection = FindIntersection(arr1, arr2)
print(intersection)
# Output: [2, 3]
```

```text
[2, 3]
```


### 82. Convert Days to Years, Months, and Days

The DaysToYearsMonthsDays function converts a given number of days to years, months, and remaining days.

```python
def DaysToYearsMonthsDays(days):
    years = days // 365
    months = (days % 365) // 30
    remaining_days = (days % 365) % 30
    return f"{years} years, {months} months, and {remaining_days} days"
# Example usage
print(DaysToYearsMonthsDays(1000))
# Output: 2 years, 9 months, and 0 days
```

```text
2 years, 9 months, and 0 days
```

> [!NOTE]
> **Output comment corrected.** `1000 % 365 = 270` and `270 % 30 = 0`, so the result is `2 years, 9 months, and 0 days` (book: `5 days`). 365-day years and 30-day months are rough approximations anyway.


### 83. Check if an Object is Empty

The IsEmptyObject function checks if a given object has no own properties.

```python
def IsEmptyObject(obj):
    return len(obj) == 0
# Example usage
print(IsEmptyObject({}))
# Output: True
print(IsEmptyObject({"name": "John", "age": 30}))
# Output: False
```

```text
True
False
```


### 84. Count Decimal Places

The GetDecimalPlaces function takes a number represented as a string and returns the number of decimal places it has. If the number has no decimal places, it returns 0.

```python
def GetDecimalPlaces(num):
    if "." in num:
        return len(num.split(".")[1])
    else:
        return 0
# Example usage
print(GetDecimalPlaces("3.14159"))
# Output: 5
print(GetDecimalPlaces("100.345"))
# Output: 3
print(GetDecimalPlaces("10.000"))
# Output: 3
print(GetDecimalPlaces("32"))
# Output: 0
```

```text
5
3
3
0
```


### 85. Remove Whitespace from a String

The RemoveWhitespace function removes all whitespace characters from a given string.

```python
def RemoveWhitespace(str):
    return "".join(str.split())
# Example usage
print(RemoveWhitespace(" Hello, world! "))
# Output: Hello,world!
```

```text
Hello,world!
```


### 86. Find the Difference between Two Arrays

The ArrayDifference function finds the difference between two arrays.

```python
def ArrayDifference(arr1, arr2):
    return list(set(arr1) - set(arr2))
# Example usage
arr1 = [1, 2, 3]
arr2 = [2, 3, 4]
difference = ArrayDifference(arr1, arr2)
print(", ".join(map(str, difference)))
# Output: 1
```

```text
1
```


### 87. Check if a Number is a Fibonacci Number

The IsFibonacci function checks if a number is a Fibonacci number.

```python
def IsFibonacci(num):
    return IsPerfectSquare(5 * num * num + 4) or IsPerfectSquare(5 * num * num - 4)
def IsPerfectSquare(num):
    sqrt = int(num ** 0.5)
    return sqrt * sqrt == num
# Example usage
print(IsFibonacci(5))
# Output: True
print(IsFibonacci(6))
# Output: False
```

```text
True
False
```


### 88. Convert Hours to Minutes

The HoursToMinutes function takes a parameter hours and returns the equivalent number of minutes by multiplying hours by 60.

```python
def HoursToMinutes(hours):
    # Multiply hours by 60 to get the equivalent number of minutes
    return hours * 60
# Example usage
print(HoursToMinutes(2))
# Output: 120
```

```text
120
```


### 89. Get the First N Elements of an Array

The FirstNElements function get the first n elements of an array.

```python
def FirstNElements(arr, n):
    # Use list slicing to retrieve the first n elements of the array
    return arr[:n]
# Example usage
array = [1, 2, 3, 4, 5]
first_n_elements = FirstNElements(array, 3)
print(", ".join(map(str, first_n_elements)))
# Output: 1, 2, 3
```

```text
1, 2, 3
```


### 90. Check if a Number is Odd

The is_odd function checks if a number is odd.

```python
def is_odd(num):
    return num % 2 != 0
# Example usage
print(is_odd(5))
# Output: True
print(is_odd(4))
# Output: False
```

```text
True
False
```


### 91. Calculate the Standard Deviation of an Array of Numbers

The standard_deviation function calculates the standard deviation of an array of numbers.

```python
import math
def standard_deviation(arr):
    mean = sum(arr) / len(arr)
    sum_of_squared_differences = sum((x - mean) ** 2 for x in arr)
    return math.sqrt(sum_of_squared_differences / len(arr))
# Example usage
print(standard_deviation([1, 2, 3, 4, 5]))
# Output: 1.4142135623730951
```

```text
1.4142135623730951
```

> [!NOTE]
> **Note.** This is the *population* SD (divides by n). For a sample use `statistics.stdev` (divides by n-1).


### 92. Check if a String ends with a specific Substring

The ends_with_substring function checks if a string ends with a specific substring.

```python
def ends_with_substring(string, substring):
    return string.endswith(substring)
# Example usage
print(ends_with_substring("Hello, world!", "world!"))
# Output: True
print(ends_with_substring("Hello, world!", "Hello"))
# Output: False
```

```text
True
False
```


### 93. Calculate the Sum of Squares of an Array

The sum_of_squares function calculates the sum of squares of an array.

```python
def sum_of_squares(arr):
    return sum(x ** 2 for x in arr)
# Example usage
print(sum_of_squares([1, 2, 3, 4, 5]))
# Output: 55
```

```text
55
```


### 94. Calculate PI to N Decimal Places

The my_pi function takes an integer n and returns the mathematical constant PI to n decimal places.

```python
import math
def my_pi(n):
    return round(math.pi, n)
# Example usage
print(my_pi(5))
# Output: 3.14159
```

```text
3.14159
```


### 95. Generate an Array of Random Numbers

The random_array function generates an array of random numbers.

<!-- nondeterministic -->
```python
import random
def random_array(length):
    return [random.randint(0, 99) for _ in range(length)]
# Example usage
random_numbers = random_array(5)
print(random_numbers)
# Output (varies), e.g.: [49, 97, 53, 5, 33]
```

```text
[49, 97, 53, 5, 33]
```


### 96. Join Path Portions

The join_path function receives two portions of a path and joins them using the "/" separator. If the separator is missing between the portions, it is added before joining.

```python
def join_path(portion1, portion2):
    return f"{portion1.rstrip('/')}/{portion2.lstrip('/')}"
# Example usage
print(join_path("portion1", "portion2"))
# Output: portion1/portion2
```

```text
portion1/portion2
```


### 97. Convert Seconds to Hours, Minutes, and Seconds

The seconds_to_hours_mins_secs function convert seconds to hours, minutes, and remaining seconds.

```python
def seconds_to_hours_mins_secs(seconds):
    hours = seconds // 3600
    remaining_seconds = seconds % 3600
    minutes = remaining_seconds // 60
    remaining_minutes = remaining_seconds % 60
    return f"{hours} hours, {minutes} minutes, and {remaining_minutes} seconds"
# Example usage
print(seconds_to_hours_mins_secs(7320))
# Output: 2 hours, 2 minutes, and 0 seconds
```

```text
2 hours, 2 minutes, and 0 seconds
```


### 98. Simple calculator

The calculator function calculates different operations.

```python
import operator
def calculator(num1, op, num2):
    # look the operator up first, so only the requested operation runs
    return {'+': operator.add, '-': operator.sub, '*': operator.mul, '/': operator.truediv}[op](num1, num2)
# Example usage
print(calculator(5, '+', 3))
# Output: 8
print(calculator(10, '-', 4))
# Output: 6
print(calculator(6, '*', 2))
# Output: 12
print(calculator(20, '/', 5))
# Output: 4.0
print(calculator(7, '+', 0))
# Output: 7
```

```text
8
6
12
4.0
7
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: The dict evaluates **every** operation up front, so `calculator(1, '+', 0)` raises `ZeroDivisionError`. Also, `20 / 5` prints `4.0`. Dispatch on functions instead.
>
> Original book code (do not use):
>
> ```python
> def calculator(num1, op, num2):
>     return {'+': num1 + num2, '-': num1 - num2, '*': num1 * num2, '/': num1 / num2}[op]
> # Example usage
> print(calculator(5, '+', 3))   # Addition outputs: 8
> print(calculator(10, '-', 4)) # Subtraction outputs: 6
> print(calculator(6, '*', 2))   # Multiplication outputs: 12
> print(calculator(20, '/', 5)) # Division outputs: 4
> ```


### 99. Find Nemo

The find_nemo function function takes a string of words as input and searches for the word "Nemo". If "Nemo" is found, it returns a string indicating the position of "Nemo" in the sentence. If "Nemo" is not found, it returns a message indicating its absence.

```python
def find_nemo(sentence):
    words = sentence.split()
    index = words.index("Nemo") + 1 if "Nemo" in words else -1
    return f"I found Nemo at {index}!" if index > 0 else "I can't find Nemo :("
# Example usage
print(find_nemo("I am finding Nemo"))
# Output: I found Nemo at 4!
```

```text
I found Nemo at 4!
```

> [!NOTE]
> **Output comment corrected.** In "I am finding Nemo", Nemo is word 4 and the code prints 4. The book's `3` is wrong.


### 100. Count the occurrences of a character in a String

The count_occurrences function counts the occurrences of a character in a String.

```python
def count_occurrences(string, char):
    return string.count(char)
# Example usage
print(count_occurrences("hello world", 'l'))
# Output: 3
```

```text
3
```


## Entries 101–150

### 101. Convert Video Length to Seconds

The minutes_to_seconds function takes the length of a video in the format "mm:ss" and converts it to seconds. If the input format is correct, it returns the length of the video in seconds; otherwise, it returns 0.

```python
def minutes_to_seconds(time):
    minutes, seconds = map(int, time.split(':'))
    return minutes * 60 + seconds if 0 <= seconds < 60 else 0
# Example usage
print(minutes_to_seconds("02:54"))
# Output: 174
```

```text
174
```


### 102. Remove Duplicates from a String

The remove_duplicates_from_string function removes duplicates from a String.

```python
def remove_duplicates_from_string(string):
    return ''.join(sorted(set(string), key=string.index))
# Example usage
print(remove_duplicates_from_string("hello"))
# Output: helo
```

```text
helo
```


### 103. Find the Mode of an Array of Numbers

The mode function finds the mode of an array of numbers.

```python
def mode(arr):
    occurrences = {}
    for num in arr:
        if num in occurrences:
            occurrences[num] += 1
        else:
            occurrences[num] = 1
    max_occurrences = max(occurrences.values())
    return [num for num, count in occurrences.items() if count == max_occurrences]
# Example usage
numbers = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
print(f"Mode: {mode(numbers)}")
# Output: Mode: [4]
```

```text
Mode: [4]
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `max`/`return` sit after the loop. Read literally, the flattened PDF text returns inside the loop and prints `Mode: [1]`.


### 104. Check for Repdigit

The is_repdigit function checks if a given integer is a repdigit, meaning it is composed of the same digit repeated. If the integer is a repdigit, it returns true; otherwise, it returns false.

```python
def is_repdigit(num):
    return len(set(str(num))) == 1
# Example usage
print(is_repdigit(333))
# Output: True
```

```text
True
```


### 105. Convert Binary Number to Decimal

The binary_to_decimal function converts a binary number to decimal.

```python
def binary_to_decimal(binary):
    return sum(int(bit) * 2**index for index, bit in enumerate(reversed(binary)))
# Example usage
print(binary_to_decimal("1101"))
# Output: 13
```

```text
13
```


### 106. Check if an Array is Sorted in Descending Order

The sorted_descending function checks if an array is sorted in descending order.

```python
def sorted_descending(arr):
    return all(arr[i] >= arr[i + 1] for i in range(len(arr) - 1))
# Example usage
print(sorted_descending([5, 4, 3, 2, 1]))
# Output: True
print(sorted_descending([1, 5, 3, 8, 2]))
# Output: False
```

```text
True
False
```


### 107. Find the Average of Even Numbers in an Array

The average_of_even_numbers function finds the average of even numbers in an array.

```python
def average_of_even_numbers(arr):
    even_numbers = [num for num in arr if num % 2 == 0]
    return sum(even_numbers) / len(even_numbers) if even_numbers else 0
# Example usage
print(average_of_even_numbers([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
# Output: 6.0
```

```text
6.0
```


### 108. Capitalize the First Letter of Each Word in a String

The capitalize_words capitalizes the first letter of each word in a String.

```python
def capitalize_words(string):
    return string.title()
# Example usage
print(capitalize_words("hello world"))
# Output: Hello World
```

```text
Hello World
```


### 109. Check if an Array is a Subset of Another Array

The is_subset function checks if an array is a subset of another array.

```python
def is_subset(arr1, arr2):
    return all(item in arr2 for item in arr1)
# Example usage
print(is_subset([1, 2, 3], [2, 3, 4, 5, 6]))
# Output: False
print(is_subset([1, 2, 3], [2, 3, 1, 5, 6]))
# Output: True
```

```text
False
True
```


### 110. Find the Minimum and Maximum Numbers in an Array

The min_max function finds the minimum and maximum numbers in an array.

```python
def min_max(arr):
    return min(arr), max(arr)
# Example usage
result = min_max([10, 5, 25, 3, 15])
print(f"{{ min: {result[0]}, max: {result[1]} }}")
# Output: { min: 3, max: 25 }
```

```text
{ min: 3, max: 25 }
```


### 111. Validate Zip Code

The is_valid function validates whether a given string is a valid zip code.

```python
import re
def is_valid(zip_code):
    return bool(re.match(r'^\d{5}$', zip_code))
# Example usage
print(is_valid("12345"))
# Output: True
print(is_valid("1234"))
# Output: False
print(is_valid("123456"))
# Output: False
print(is_valid("12 45"))
# Output: False
```

```text
True
False
False
False
```


### 112. Remove Null Values from a List

The remove_null function removes null values from a list.

```python
def remove_null(arr):
    return [item for item in arr if item is not None]
# Example usage
array = [1, None, 2, 3, None, 4, None]
result = remove_null(array)
print(f"Output: {result}")
# Output: Output: [1, 2, 3, 4]
```

```text
Output: [1, 2, 3, 4]
```


### 113. Maurice's Racing Snails

Maurice and Steve engage in a snail race, each owning three snails of different speeds: slow (s), medium (m), and fast (f). Although Maurice's snails are generally faster, Steve's strategy poses a challenge. In each of the three rounds, they pit their snails against each other strategically. Maurice's plan involves sacrificing his slower snails strategically to ensure victory. This function evaluates Maurice's plan, determining if he wins at least 2 out of 3 games against Steve's snails.

```python
def maurice_wins(m_snails, s_snails):
    # Maurice sacrifices his slowest snail against Steve's fastest,
    # then plays medium vs slow and fast vs medium
    m, s = sorted(m_snails), sorted(s_snails)
    return sum([m[0] > s[2], m[1] > s[0], m[2] > s[1]]) >= 2
# Example usage:
print(maurice_wins([3, 5, 10], [4, 7, 11]))
# Output: True
print(maurice_wins([6, 8, 9], [7, 12, 14]))
# Output: False
print(maurice_wins([1, 8, 20], [2, 9, 100]))
# Output: True
```

```text
True
False
True
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: With `[1,2,3]` vs `[3,2,1]` only `3 > 1` wins, so the result is `False` (book: `True`). The "sacrifice the slow snail" strategy from the description isn't implemented.
>
> Original book code (do not use):
>
> ```python
> def maurice_wins(m_snails, s_snails):
>     wins = sum(m > s for m, s in zip(m_snails, s_snails))
>     return wins >= 2
> # Example usage:
> print(maurice_wins([1, 2, 3], [3, 2, 1]))
> # Output: True
> ```


### 114. Calculate the Sum of Cubes of an Array

The sum_of_cubes function calculates the sum of cubes of an array.

```python
def sum_of_cubes(arr):
    return sum(x ** 3 for x in arr)
# Example usage:
arr = [1, 2, 3, 4, 5]
sum_result = sum_of_cubes(arr)
print(f"Output: {sum_result}")
# Output: Output: 225
```

```text
Output: 225
```


### 115. Shuffle the Characters of a String

The shuffle_string function suffle the characters of a String.

<!-- nondeterministic -->
```python
import random
def shuffle_string(s):
    shuffled_chars = list(s)
    random.shuffle(shuffled_chars)
    return ''.join(shuffled_chars)
# Example usage:
s = "hello"
shuffled_string = shuffle_string(s)
print(f"Output: {shuffled_string}")
# Output (varies), e.g.: Output: lehol
```

```text
Output: lehol
```


### 116. Find the Nth Fibonacci Number (recursive)

The fibonacci function finds the nth fibonacci number (recursive).

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)
# Example usage:
n=7
result = fibonacci(n)
print(f"Output: {result}")
# Output: Output: 13
```

```text
Output: 13
```


### 117. Symmetry Checker

The is_symmetrical function determines whether a given integer is symmetrical, meaning it reads the same backward as forward.

```python
def is_symmetrical(num):
    return str(num) == str(num)[::-1]
num = 12321
print(is_symmetrical(num))
# Output: True
```

```text
True
```


### 118. Maximum Triangle Edge Calculator

The next_edge function provides a concise function for determining the maximum possible length of the third edge of a triangle, given the lengths of the other two sides as integers.

```python
def next_edge(side1, side2):
    return side1 + side2 - 1
side1 = 5
side2 = 7
print(next_edge(side1, side2))
# Output: 11
```

```text
11
```


### 119. Calculate the Perimeter of a Rectangle

The rectangle_perimeter function calculates the perimeter of a rectangle given its width and height.

```python
def rectangle_perimeter(width, height): return 2 * (width + height)
print(rectangle_perimeter(5, 10))
# Output: 30
```

```text
30
```


### 120. Find the Longest Common Prefix in an Array of Strings

The longest_common_prefix function finds the longest common prefix among an array of strings.

```python
def longest_common_prefix(strs):
    return "" if not strs else next((strs[0][:i] for i, chars in enumerate(zip(*strs)) if len(set(chars)) > 1), min(strs, key=len))
# Test
strs = ["apple", "apricot", "appetizer"]
print(longest_common_prefix(strs))
# Output: ap
print(longest_common_prefix(["flower", "flow", "flight"]))
# Output: fl
print(repr(longest_common_prefix(["abc", "xbc"])))
# Output: ''
```

```text
ap
fl
''
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: This isn't a prefix. It keeps every column where all strings agree and never stops at the first mismatch: `["abc","xbc"]` returns `"bc"`, and `["flower","flow","flight"]` raises `IndexError`.
>
> Original book code (do not use):
>
> ```python
> def longest_common_prefix(strs): return "" if not strs else "".join(c for i, c in enumerate(strs[0]) if all(s[i] == c for s in strs))
> # Test
> strs = ["apple", "apricot", "appetizer"]
> print(longest_common_prefix(strs))
> # Output: "ap"
> ```


### 121. Greeting Function with Conditional Message

The say_hello_bye function introduces a one-liner function that takes a string name and a number (either 0 or 1) as input. Depending on the value of the number, it either greets the person with "Hello" or bids farewell with "Bye", while ensuring the name's first letter is capitalized. The function utilizes a ternary conditional operator for succinctness and clarity.

```python
def say_hello_bye(name, num): return f"Hello {name.capitalize()}" if num == 1 else f"Bye {name.capitalize()}"
name = "Alice"
num = 2
print(say_hello_bye(name, num))
# Output: Bye Alice
```

```text
Bye Alice
```


### 122. Find the First Non-Repeated Character in a String

The first_non_repeated_char function finds the first non-repeated character in a String.

```python
def first_non_repeated_char(s): return next((c for c in s if s.count(c) == 1), None)
s = "abacabad"
print(first_non_repeated_char(s))
# Output: c
```

```text
c
```


### 123. One-Liner Bitwise Operations in Python

These bitwise_and, bitwise_or, and bitwise_xor functions work similarly to the lambda expressions but use the def keyword for function definition. They take two integers n1 and n2 as input and return the result of the respective bitwise AND, OR, and XOR operations between them.

```python
def bitwise_and(n1, n2):
    return n1 & n2
def bitwise_or(n1, n2):
    return n1 | n2
def bitwise_xor(n1, n2):
    return n1 ^ n2
num1, num2 = 5, 3
print(bitwise_and(num1, num2))
# Output: 1
print(bitwise_or(num1, num2))
# Output: 7
print(bitwise_xor(num1, num2))
# Output: 6
```

```text
1
7
6
```


### 124. Calculate the Exponential of a Number

The exponential function calculates the result of raising a given base to a specified exponent using the exponentiation operator (**).

```python
def exponential(base, exponent):
    return base ** exponent
result = exponential(2, 3)
print(result)
# Output: 8
```

```text
8
```


### 125. Check if a String is an Anagram of Another String

The is_anagram function checks if a string is an anagram of another string.

```python
def is_anagram(str1, str2):
    return sorted(str1) == sorted(str2)
print(is_anagram("listen", "silent"))
# Output: True
print(is_anagram("hello", "world"))
# Output: False
```

```text
True
False
```


### 126. Compact Phone Number Formatter

The format_phone_number function offers a concise function to format an array of 10 numbers into a phone number string in the standard (XXX) XXX-XXXX format.

```python
def format_phone_number(numbers):
    return "({}{}{}) {}{}{}-{}{}{}{}".format(*numbers)
numbers = [5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
print(format_phone_number(numbers))
# Output: (555) 555-5555
```

```text
(555) 555-5555
```


### 127. Check if a Number is a Neon Number

The is_neon_number function checks if a number is a neon number.

```python
def is_neon_number(num):
    sum_of_digits = 0
    square = num * num
    while square:
        sum_of_digits += square % 10
        square //= 10
    return sum_of_digits == num
print(is_neon_number(9))
# Output: True
```

```text
True
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `return` goes after the `while` loop.


### 128. Recursive Right Shift Mimicker

The shift_to_right function employs recursion to repeatedly divide the first integer by 2 y times, emulating the right shift operation. This approach offers a compact and elegant solution for performing right shifts between two given integers.

```python
def shift_to_right(x, y):
    return x if y < 1 else shift_to_right(x // 2, y - 1)
x = 16
y=2
print(shift_to_right(x, y))
# Output: 4
```

```text
4
```


### 129. Check if a Number is a Disarium Number

The is_disarium_number function checks if a number is a disarium number.

```python
def is_disarium_number(num):
    num_str = str(num)
    disarium_sum = sum(int(digit) ** (i + 1) for i, digit in enumerate(num_str))
    return disarium_sum == num
# Test cases
print(is_disarium_number(89))
# Output: True
print(is_disarium_number(135))
# Output: True
print(is_disarium_number(23))
# Output: False
```

```text
True
True
False
```


### 130. Remove Vowels from a String

The remove_vowels function removes vowels from a string.

```python
import re
def remove_vowels(string):
    return re.sub(r'[aeiouAEIOU]', '', string)
# Test case
print(remove_vowels("Hello, World!"))
# Output: Hll, Wrld!
```

```text
Hll, Wrld!
```


### 131. Generate an Array of Consecutive Numbers

The consecutive_numbers function generates an array of consecutive numbers.

```python
def consecutive_numbers(start, end_num):
    return list(range(start, end_num + 1))
# Test case
result = consecutive_numbers(1, 5)
print(", ".join(map(str, result)))
# Output: 1, 2, 3, 4, 5
```

```text
1, 2, 3, 4, 5
```


### 132. Check if a Number is a Pronic Number

The is_pronic_number function checks if a number is a pronic number.

```python
def is_pronic_number(num):
    n = int(num ** 0.5)
    return n * (n + 1) == num
# Test cases
print(is_pronic_number(6))
# Output: True
print(is_pronic_number(20))
# Output: True
print(is_pronic_number(7))
# Output: False
```

```text
True
True
False
```


### 133. Check if a String is a Pangram

The is_pangram function checks if a string is a pangram.

```python
def is_pangram(s):
    letters = set(c.lower() for c in s if c.isalpha())
    return len(letters) == 26
# Test cases
print(is_pangram("The quick brown fox jumps over the lazy dog"))
# Output: True
print(is_pangram("Hello, World!"))
# Output: False
```

```text
True
False
```


### 134. Reverse the Order of Words in a Sentence

The reverse_sentence function reverses the order of words in a sentence.

```python
def reverse_sentence(sentence):
    words = sentence.split()
    reversed_sentence = ' '.join(reversed(words))
    return reversed_sentence
# Test case
print(reverse_sentence("Hello, how are you doing?"))
# Output: doing? you are how Hello,
```

```text
doing? you are how Hello,
```


### 135. Calculate the Hypotenuse of a Right-Angled Triangle

The calculate_hypotenuse function calculates the hypotenuse of a right-angled triangle.

```python
import math
def calculate_hypotenuse(a, b):
    return math.sqrt(a ** 2 + b ** 2)
# Test case
print(calculate_hypotenuse(3, 4))
# Output: 5.0
```

```text
5.0
```


### 136. Find the Average of Odd Numbers in an Array

The average_of_odd_numbers function finds the average of odd numbers in an array.

```python
def average_of_odd_numbers(arr):
    odd_numbers = [num for num in arr if num % 2 != 0]
    return sum(odd_numbers) / len(odd_numbers) if odd_numbers else 0
# Test case
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(average_of_odd_numbers(numbers))
# Output: 5.0
```

```text
5.0
```


### 137. Count the Letters in a String (case-insensitive)

The count_letters function counts the letter in a String (case-insensitve).

```python
def count_letters(s):
    return {char: s.lower().count(char) for char in s.lower() if char.isalpha()}
# Test case
input_str = "Hello, World!"
result = count_letters(input_str)
for char, count in result.items():
    print(f"{char} => {count}")
# Output:
#   h => 1
#   e => 1
#   l => 3
#   o => 2
#   w => 1
#   r => 1
#   d => 1
```

```text
h => 1
e => 1
l => 3
o => 2
w => 1
r => 1
d => 1
```


### 138. Convert Seconds to Days, Hours, Minutes, and Seconds

The secs_to_days_hours_mins_secs function converts seconds to days, hours, minutes, and seconds.

```python
def secs_to_days_hours_mins_secs(seconds):
    days = seconds // 86400
    hours = (seconds % 86400) // 3600
    minutes = ((seconds % 86400) % 3600) // 60
    secs = ((seconds % 86400) % 3600) % 60
    return f"{days} days, {hours} hours, {minutes} minutes, and {secs} seconds"
# Test case
seconds = 100000
print(secs_to_days_hours_mins_secs(seconds))
# Output: 1 days, 3 hours, 46 minutes, and 40 seconds
```

```text
1 days, 3 hours, 46 minutes, and 40 seconds
```


### 139. Check if a Number is a Prime Factor of Another Number

The is_prime_factor function checks if a given number factor is a prime factor of another number num.

```python
def is_prime_factor(num, factor):
    return num % factor == 0 and all(factor % i != 0 for i in range(2, int(factor**0.5) + 1)) and factor > 1
# Test cases
num = 20
factor = 2
print(is_prime_factor(num, factor))
# Output: True
factor = 3
print(is_prime_factor(num, factor))
# Output: False
```

```text
True
False
```


### 140. Find the Largest Prime Factor of a Number

The largest_prime_factor function calculates the largest prime factor of a given number.

```python
def largest_prime_factor(num):
    factor = 2
    while factor * factor <= num:
        if num % factor:
            factor += 1
        else:
            num //= factor
    return num
# Test case
print(largest_prime_factor(48))
# Output: 3
print(largest_prime_factor(13195))
# Output: 29
```

```text
3
29
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Returns the **smallest** prime factor. 48 = 2^4 x 3, so the largest is 3.
>
> Original book code (do not use):
>
> ```python
> def largest_prime_factor(num):
>     if num == 1:
>         return 1
>     factor = next((x for x in range(2, int(num**0.5) + 1) if num % x == 0 and all(x % y != 0 for y in range(2, int(x**0.5) + 1))), 0)
>     return num if factor == 0 else factor
> # Test case
> print(largest_prime_factor(48))
> # Output: 2
> ```


### 141. Check if a Number is a Pronic Square

The is_pronic_square function checks if the square root of the given number num is an integer, indicating that num is a perfect square.

```python
def is_pronic_square(num):
    # despite the name, this tests for a perfect square (as the book's description says)
    sqrt = num ** 0.5
    return sqrt == int(sqrt)
# Test cases
print(is_pronic_square(6))
# Output: False
print(is_pronic_square(20))
# Output: False
print(is_pronic_square(16))
# Output: True
```

```text
False
False
True
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: The code tests for a perfect square, so 6 and 21 both return `False` (book: `True`). "Pronic square" is not a standard term.
>
> Original book code (do not use):
>
> ```python
> def is_pronic_square(num):
>     sqrt = num ** 0.5
>     return sqrt == int(sqrt)
> # Test cases
> print(is_pronic_square(6))
> # Output: True
> print(is_pronic_square(20))
> # Output: False
> print(is_pronic_square(21))
> # Output: True
> ```


### 142. World Landmass Proportion Calculator

The area_of_country function calculates a country's proportion of the total world's landmass based on its name and area.

```python
def area_of_country(name, area):
    return f"{name} is {area * 100 / 148940000:.2f}% of the total world's landmass"
# Test case
country_name = "Canada"
country_area = 9984670 # in square kilometers
print(area_of_country(country_name, country_area))
# Output: Canada is 6.70% of the total world's landmass
```

```text
Canada is 6.70% of the total world's landmass
```

> [!NOTE]
> **Output comment corrected.** 9984670 x 100 / 148940000 = 6.7038, which prints as `6.70%` (book: `6.71%`).


### 143. Loaded Die Detection

The is_unloaded function calculates derivatives of frequencies and compares them to a critical value.

```python
def is_unloaded(counts):
    # chi-square goodness-of-fit on observed COUNTS of faces 1-6
    expected = sum(counts) / len(counts)
    chi2 = sum((o - expected) ** 2 / expected for o in counts)
    return chi2 < 11.0705  # critical value, df = 5, alpha = 0.05
# Test case
print(is_unloaded([16, 18, 16, 14, 12, 24]))
# Output: True
print(is_unloaded([8, 9, 10, 12, 11, 50]))
# Output: False
```

```text
True
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: This isn't a statistical test. `11.0705` is the chi-square critical value for df=5, alpha=0.05, so it must be compared with the chi-square statistic computed on **counts**.
>
> Original book code (do not use):
>
> ```python
> def is_unloaded(frequencies):
>     return sum(f * (i + 1) ** (f - 1) for i, f in enumerate(frequencies)) > 11.0705
> # Test case
> frequencies = [0.02, 0.03, 0.05, 0.1, 0.2, 0.6]
> print(is_unloaded(frequencies))
> # Output: True or False
> ```


### 144. Hand Washing Duration Calculator

The wash_hands function calculates the total duration a person spends washing their hands based on the number of times they wash their hands per day (N) and the number of months (nM) they follow this routine.

```python
def wash_hands(N, nM):
    total_seconds = nM * N * 21 * 30
    minutes = total_seconds // 60
    seconds = total_seconds % 60
    return f"{minutes} minutes and {seconds} seconds"
# Test case
N = 3 # Number of times a person washes their hands per day
nM = 2 # Number of months they follow this routine
print(wash_hands(N, nM))
# Output: 63 minutes and 0 seconds
```

```text
63 minutes and 0 seconds
```


### 145. Check if a Number is a Happy Number

The is_happy_number function checks if a given number is a "happy number" or not.

```python
def is_happy_number(num):
    seen = set()
    while num != 1 and num not in seen:
        seen.add(num)
        num = sum(int(d) ** 2 for d in str(num))
    return num == 1
# Test case
print("true" if is_happy_number(19) else "false")
# Output: true
print("true" if is_happy_number(4) else "false")
# Output: false
```

```text
true
false
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: It hard-codes a few guesses instead of iterating sum-of-squared-digits. 19 *is* happy (1+81=82 -> 68 -> 100 -> 1), yet the code prints `false`.
>
> Original book code (do not use):
>
> ```python
> def is_happy_number(num):
>     return num == 1 or num == 7 or num == 10 or (num < 100 and num % 10 == 0 and num % 11 == 0) or (num < 1000 and num % 100 == 0 and num % 111 == 0)
> # Test case
> print("true" if is_happy_number(19) else "false")
> # Output: false
> ```


### 146. Billable Days Bonus Calculator

The calculate_bonus function efficiently computes the bonus using predefined thresholds and rates, ensuring accurate compensation for the employee's performance.

```python
def calculate_bonus(days):
    return 325 * max(days - 32, 0) + 225 * max(days - 40, 0) + 50 * max(days - 48, 0)
# Example usage
billable_days = 45
bonus = calculate_bonus(billable_days)
print(f"Bonus for {billable_days} billable days: {bonus}")
# Output: Bonus for 45 billable days: 5350
```

```text
Bonus for 45 billable days: 5350
```


### 147. Calculate the Volume of a Sphere

The sphere_volume function calculates the volume of a sphere given its radius.

```python
import math
def sphere_volume(radius):
    return (4/3) * math.pi * radius ** 3
# Example usage
volume = sphere_volume(5)
print(volume)
# Output: 523.5987755982989
```

```text
523.5987755982989
```


### 148. Discounted Price Calculator

The calculate_final_price function takes the original price and the discount percentage as integers and returns the discounted price.

```python
def calculate_final_price(price, discount):
    return price * (100 - discount) * 0.01
# Example usage
final_price = 100 # Final price
discount = 20 # Discount percentage
discounted_price = calculate_final_price(final_price, discount)
print(f"Final price after {discount}% discount: {discounted_price}")
# Output: Final price after 20% discount: 80.0
```

```text
Final price after 20% discount: 80.0
```


### 149. Double Letter Checker

The has_double_letters function takes a word as input and returns true if the word contains two consecutive identical letters, and false otherwise.

```python
import re
def has_double_letters(word):
    return bool(re.search(r"(\w)\1", word))
# Example usage:
word = "hello" # Word to check for double letters
has_double_letters = has_double_letters(word)
print(f"Does the word '{word}' have double letters? {has_double_letters}")
# Output: Does the word 'hello' have double letters? True
```

```text
Does the word 'hello' have double letters? True
```


### 150. Find the Length of the Longest Word in a Sentence

The longest_word_length function finds the length of the longest word in a sentence.

```python
def longest_word_length(sentence):
    return max(len(word) for word in sentence.split())
# Example usage:
sentence = "The quick brown fox jumped over the lazy dog"
print(longest_word_length(sentence))
# Output: 6
```

```text
6
```


## Entries 151–200

### 151. Stolen Items Loss Calculator

The calculate_losses function takes a dictionary of stolen items and their values as input and returns the difference between the total value of those items and the policy limit.

```python
def calculate_losses(stolen_items):
    total_value = sum(stolen_items.values())
    return "Lucky you!" if total_value == 0 else total_value
# Example usage:
stolen_items = {
    "watch": 100,
    "phone": 200,
    "wallet": 50
}
losses = calculate_losses(stolen_items)
print(f"Losses: {losses}")
# Output: Losses: 350
```

```text
Losses: 350
```


### 152. Hacker Speak Converter

The convert_to_hacker_speak function takes a string as input and returns its hacker speak equivalent, replacing characters 'a', 'e', 'i', 'o', and 's' with '4', '3', '1', '0', and '5' respectively.

```python
import re
def convert_to_hacker_speak(input_str):
    return re.sub('[aeios]', lambda x: '4' if x.group() == 'a' else '3' if x.group() == 'e' else '1' if x.group() == 'i' else '0' if x.group() == 'o' else '5', input_str)
# Example usage:
input_str = "hello world"
hacker_speak = convert_to_hacker_speak(input_str)
print(f"Original: {input_str}")
# Output: Original: hello world
print(f"Hacker Speak: {hacker_speak}")
# Output: Hacker Speak: h3ll0 w0rld
```

```text
Original: hello world
Hacker Speak: h3ll0 w0rld
```


### 153. Find the Area of a Rectangle

The rectangle_area function finds the area of a rectangle.

```python
def rectangle_area(length, width):
    return length * width
# Example usage:
length = 5
width = 10
area = rectangle_area(length, width)
print(f"Area: {area}")
# Output: Area: 50
```

```text
Area: 50
```


### 154. Calculate the Sum of Even Numbers in an Array

The sum_of_even_numbers calculates the sum of even numbers in an array.

```python
def sum_of_even_numbers(arr):
    return sum(num for num in arr if num % 2 == 0)
# Example usage:
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
sum = sum_of_even_numbers(arr)
print(f"Sum of even numbers: {sum}")
# Output: Sum of even numbers: 30
```

```text
Sum of even numbers: 30
```


### 155. Missing Number Finder

The find_missing_number function takes an array of numbers as input and returns the missing number. It efficiently calculates the missing number by subtracting the sum of the given array from the sum of all numbers from 1 to 10.

```python
def find_missing_number(arr):
    n = len(arr) + 1  # the full sequence is 1..n
    return n * (n + 1) // 2 - sum(arr)
# Example usage:
numbers = [1, 2, 3, 4, 6, 7, 8, 9, 10]
missing_number = find_missing_number(numbers)
print(f"Missing number: {missing_number}")
# Output: Missing number: 5
```

```text
Missing number: 5
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Hard-codes `55` = 1+...+10, so it only works for exactly 1..10.
>
> Original book code (do not use):
>
> ```python
> def find_missing_number(arr):
>     return 55 - sum(arr)
> # Example usage:
> numbers = [1, 2, 3, 4, 6, 7, 8, 9, 10]
> missing_number = find_missing_number(numbers)
> print(f"Missing number: {missing_number}")
> # Output: Missing number: 5
> ```


### 156. Calculate the Volume of a Cylinder

The cylinder_volume function calculates the volume of a cylinder.

```python
import math
def cylinder_volume(radius, height):
    return math.pi * radius ** 2 * height
# Example usage:
volume = cylinder_volume(5, 10)
print(f"Volume of the cylinder: {volume}")
# Output: Volume of the cylinder: 785.3981633974483
```

```text
Volume of the cylinder: 785.3981633974483
```

> [!NOTE]
> **Output comment corrected.** Python prints `785.3981633974483`; the book drops a digit.


### 157. BBQ Skewer Analyzer

The bbq_skewers method takes a list of skewers as input and returns the count of vegetarian and non-vegetarian skewers. A vegetarian skewer contains only vegetables ("-o"), while a non-vegetarian skewer contains at least one piece of meat ("-x").

```python
def bbq_skewers(grill):
    vegetarian_count = sum(1 for skewer in grill if "-x" not in skewer)
    non_vegetarian_count = len(grill) - vegetarian_count
    return [vegetarian_count, non_vegetarian_count]
# Example usage:
grill = ["-o", "-o", "-x", "-o", "-x"] # Grill skewers
result = bbq_skewers(grill)
print(f"Vegetarian skewers: {result[0]}, Non-vegetarian skewers: {result[1]}")
# Output: Vegetarian skewers: 3, Non-vegetarian skewers: 2
```

```text
Vegetarian skewers: 3, Non-vegetarian skewers: 2
```


### 158. Convert Decimal Number to Octal

The decimal_to_octal function converts decimal number to octal.

```python
def decimal_to_octal(num):
    return format(num, "o")
# Example usage:
print(decimal_to_octal(27))
# Output: 33
print(decimal_to_octal(0))
# Output: 0
```

```text
33
0
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `lstrip("0o")` strips *characters*, not a prefix, so `decimal_to_octal(0)` returns `''`. Use `format(n, 'o')`. #169 (hex) has the same bug.
>
> Original book code (do not use):
>
> ```python
> def decimal_to_octal(num):
>     return oct(num).lstrip("0o")
> # Example usage:
> print(decimal_to_octal(27))
> # Output: "33"
> ```


### 159. Collatz Sequence Analyzer

The Collatz method takes a positive integer as input and returns the number of steps required to reach 1 in the Collatz sequence.

```python
def collatz(num):
    count = 0
    while num != 1:
        num = num // 2 if num % 2 == 0 else 3 * num + 1
        count += 1
    return count
# Example usage:
num = 27
steps = collatz(num)
print(f"Number of steps to reach 1 in Collatz sequence for {num}: {steps}")
# Output: Number of steps to reach 1 in Collatz sequence for 27: 111
```

```text
Number of steps to reach 1 in Collatz sequence for 27: 111
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `return` goes after the `while` loop (with it inside, 27 gives 1 step, not 111).


### 160. Check if a String is a Valid Phone Number (North American Format)

The is_valid_phone_number function checks if a string is a valid phone number (north american format).

```python
import re
def is_valid_phone_number(phone):
    return bool(re.match(r'^\d{3}-\d{3}-\d{4}$', phone))
# Example usage:
print(is_valid_phone_number("555-123-4567"))
# Output: True
print(is_valid_phone_number("123-4567"))
# Output: False
```

```text
True
False
```


### 161. Find the Sum of the First N Natural Numbers

The sum_of_naturals function finds the sum of the first n natural numbers.

```python
def sum_of_naturals(n):
    return (n * (n + 1)) // 2
# Example usage:
print(sum_of_naturals(10))
# Output: 55
```

```text
55
```


### 162. Vowel Dasher

The dashed function in the StringDasher class takes a string as input and returns the modified string with dashes added around each vowel.

```python
import re
def dashed(string):
    return re.sub(r'[aeiouAEIOU]', lambda x: f'-{x.group(0)}-', string)
# Example usage:
input_str = "hello world" # Example: Input string
dashed_string = dashed(input_str)
print(f"Original: {input_str}")
# Output: Original: hello world
print(f"Dashed: {dashed_string}")
# Output: Dashed: h-e-ll-o- w-o-rld
```

```text
Original: hello world
Dashed: h-e-ll-o- w-o-rld
```


### 163. Find the Factors of a Number (excluding 1 and the number itself)

The factors function finds the factors of a number (excluding 1 and the number itself).

```python
def factors(num):
    result = []
    for i in range(2, num):
        if num % i == 0:
            result.append(i)
    return result
# Example usage:
print(", ".join(map(str, factors(12))))
# Output: 2, 3, 4, 6
```

```text
2, 3, 4, 6
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `return` goes after the `for` loop.


### 164. Calculate the Area of a Triangle given the Base and Height

The triangle_area function calculates the area of a triangle given the base and height.

```python
def triangle_area(base, height):
    return 0.5 * base * height
# Example usage:
area = triangle_area(5, 10)
print(area)
# Output: 25.0
```

```text
25.0
```


### 165. Check if a String is a Valid Social Security Number (SSN)

The is_valid_ssn function checks whether a given string is a valid Social Security Number (SSN) in the format "XXX-XX- XXXX", where X represents a digit.

```python
import re
def is_valid_ssn(ssn):
    return bool(re.match(r'^\d{3}-\d{2}-\d{4}$', ssn))
# Test cases
print(is_valid_ssn("123-45-6789"))
# Output: True
print(is_valid_ssn("123-45-678"))
# Output: False
```

```text
True
False
```


### 166. Generate an Array of Random Numbers within a Range

The random_array_in_range function generates an array of random numbers within a range.

<!-- nondeterministic -->
```python
import random
def random_array_in_range(min_val, max_val, length):
    return [random.randint(min_val, max_val) for _ in range(length)]
# Test the function
random_array = random_array_in_range(1, 100, 5)
print(random_array)
# Output (varies), e.g.: [50, 98, 54, 6, 34]
```

```text
[50, 98, 54, 6, 34]
```


### 167. XO Checker

The xo_checker function takes a string as input and returns true if the string contains an equal number of 'x's and 'o's (case- insensitive), and false otherwise.

```python
def xo_checker(string):
    x_count = string.lower().count('x')
    o_count = string.lower().count('o')
    return x_count == o_count
# Example usage:
input_str = "xoxoxo" # Example input string
result = xo_checker(input_str)
print(f"String \"{input_str}\" has the same number of 'x's and 'o's: {result}")
# Output: String "xoxoxo" has the same number of 'x's and 'o's: True
```

```text
String "xoxoxo" has the same number of 'x's and 'o's: True
```


### 168. Check if a String is a Valid IPv4 Address

The is_valid_ipv4 function checks whether a given string represents a valid IPv4 address.

```python
import re
def is_valid_ipv4(ip):
    pattern = r"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    return bool(re.match(pattern, ip))
# Example usage:
print(is_valid_ipv4("192.168.1.1"))
# Output: True
print(is_valid_ipv4("256.0.0.1"))
# Output: False
```

```text
True
False
```


### 169. Convert Decimal Number to Hexadecimal

The decimal_to_hex function converts decimal number to hexadecimal.

```python
def decimal_to_hex(num):
    return format(num, "X")
# Example usage:
print(decimal_to_hex(255))
# Output: FF
print(decimal_to_hex(0))
# Output: 0
```

```text
FF
0
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Same `lstrip` bug as #158: `decimal_to_hex(0)` returns `''`. Use `format(n, 'X')`.
>
> Original book code (do not use):
>
> ```python
> def decimal_to_hex(num):
>     return hex(num).lstrip("0x").upper()
> # Example usage:
> print(decimal_to_hex(255))
> # Output: "FF"
> ```


### 170. Check if a String is a Valid Date (YYYY-MM-DD Format)

The is_valid_date function checks whether a given string is a valid date in the format "YYYY-MM-DD".

```python
import re
def is_valid_date(date):
    return bool(re.match(r'^\d{4}-\d{2}-\d{2}$', date))
# Example usage:
print(is_valid_date("2023-08-02"))
# Output: True
print(is_valid_date("02-08-2023"))
# Output: False
```

```text
True
False
```


### 171. Chinese Zodiac Sign Identifier

The get_chinese_zodiac_sign function in the ChineseZodiac class takes a birth year as input and returns the corresponding Chinese zodiac sign.

```python
def get_chinese_zodiac_sign(birth_year):
    zodiac_signs = ["Monkey", "Rooster", "Dog", "Pig", "Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Sheep"]
    return zodiac_signs[birth_year % 12]
# Example usage:
birth_years = [2021, 2020, 1938, 1951, 1964, 1977, 1990, 2003, 2016, 1969, 1982, 1995]
for year in birth_years:
    sign = get_chinese_zodiac_sign(year)
    print(f"Year {year}: {sign}")
# Output:
#   Year 2021: Ox
#   Year 2020: Rat
#   Year 1938: Tiger
#   Year 1951: Rabbit
#   Year 1964: Dragon
#   Year 1977: Snake
#   Year 1990: Horse
#   Year 2003: Sheep
#   Year 2016: Monkey
#   Year 1969: Rooster
#   Year 1982: Dog
#   Year 1995: Pig
```

```text
Year 2021: Ox
Year 2020: Rat
Year 1938: Tiger
Year 1951: Rabbit
Year 1964: Dragon
Year 1977: Snake
Year 1990: Horse
Year 2003: Sheep
Year 2016: Monkey
Year 1969: Rooster
Year 1982: Dog
Year 1995: Pig
```


### 172. Check if a String is a Valid Password

The is_valid_password function checks if a string is a valid password (at least 8 characters, with a digit and special character).

```python
import re
def is_valid_password(password):
    # Regex pattern for a valid password:
    # - At least 8 characters
    # - At least one uppercase letter, one lowercase letter, one digit, and one special character from @$!%*?&
    pattern = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"
    return bool(re.match(pattern, password))
# Test cases
print(is_valid_password("P@ssw0rd"))
# Output: True
print(is_valid_password("password123"))
# Output: False
```

```text
True
False
```


### 173. Find the Nth Fibonacci Number

The fibonacci function finds the nth fibonacci number.

```python
def fibonacci(n):
    return n - 1 if n <= 2 else fibonacci(n - 1) + fibonacci(n - 2)
# Test case
print(fibonacci(7))
# Output: 8
```

```text
8
```


### 174. Diving Minigame Checker

The diving_minigame function takes an array of integers representing the scores and returns true if the minigame is possible, and false otherwise.

```python
def diving_minigame(arr):
    breath = 10
    for x in arr:
        breath = breath - 2 if x < 0 else min(breath + 4, 10)  # dive costs 2, surfacing restores 4
        if breath <= 0:
            return False
    return True
# Test cases
print(diving_minigame([0, -4, 0, -4, -5, -2]))
# Output: True
print(diving_minigame([-4, -3, -4, -3, 5, 2, -5, -20, -42, -4, 5, 3, 5]))
# Output: True
print(diving_minigame([1, 2, 1, 2, 1, 2, 1, 2, 1, -3, -4, -5, -3, -4]))
# Output: False
print(diving_minigame([-5, -5, -5, -5, -5, 2, 2, 2, 2, 2, 2, 2, 2]))
# Output: False
```

```text
True
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: All four test cases print `False`. The book claims `True, True, False, False`.
>
> Original book code (do not use):
>
> ```python
> def diving_minigame(arr):
>     return bool((lambda score: next((False for score_change in arr if score <= 0 or (score_change < 0 and (score := max(0, score - 2)) < 1) or (score_change >= 0 and (score := min(score + 4, 10)) > 0)), True))(10))
> # Test cases
> print(diving_minigame([0, -4, 0, -4, -5, -2])) # True
> print(diving_minigame([-4, -3, -4, -3, 5, 2, -5, -20, -42, -4, 5, 3, 5])) # True
> print(diving_minigame([1, 2, 1, 2, 1, 2, 1, 2, 1, -3, -4, -5, -3, -4])) # False
> print(diving_minigame([-5, -5, -5, -5, -5, 2, 2, 2, 2, 2, 2, 2, 2])) # False
> ```


### 175. Roger's Shooting Score Calculator

The roger_shots function takes an array of strings representing the shots ("Bang!" or "BangBang!") and returns the total score earned by Roger. Each "Bang!" shot contributes 0.5 points to the score, and each "BangBang!

```python
def roger_shots(arr):
    return sum(0.5 for shot in arr if shot in ["Bang!", "BangBang!"])
# Test cases
print(roger_shots(["Bang!", "Bang!", "Bang!", "Bang!", "Bang!", "Bang!"]))
# Output: 3.0
print(roger_shots(["Bang!", "Bang!", "Bang!", "Bang!", "BangBang!"]))
# Output: 2.5
print(roger_shots(["Bang!", "BangBangBang!", "Boom!", "Bang!", "BangBang!", "BangBang!"]))
# Output: 2.0
print(roger_shots(["BangBang!", "BangBang!", "BangBang!"]))
# Output: 1.5
print(roger_shots(["Bang!", "BadaBing!", "Badaboom!", "Bang!", "Bang!", "Bang!", "Bang!", "Bang!"]))
# Output: 3.0
print(roger_shots(["BangBang!", "BangBang!", "Bag!", "Ban!", "Tang!", "Bang!", "Bang!"]))
# Output: 2.0
```

```text
3.0
2.5
2.0
1.5
3.0
2.0
```


### 176. Middle Character of String

The get_middle function takes a string as input and returns the middle character(s) of the string.

```python
def get_middle(s):
    mid = len(s) // 2
    return s[mid] if len(s) % 2 != 0 else s[mid - 1:mid + 1]
# Test case
print(get_middle("middle"))
# Output: dd
```

```text
dd
```


### 177. Calculate the Volume of a Cube

The cube_volume function calculates the volume of a cube.

```python
def cube_volume(side):
    return side ** 3
# Test case
print(cube_volume(5))
# Output: 125
```

```text
125
```


### 178. Check if a String is a Valid Credit Card Number (Visa, MasterCard, Discover, American Express)

The is_valid_credit_card function checks is a string is a valid credit card number (visa, mastercard, discover, american express).

```python
import re
def is_valid_credit_card(card):
    digits = card.replace("-", "").replace(" ", "")
    regex = re.compile(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13})$')
    if not regex.match(digits):
        return False
    d = [int(c) for c in digits][::-1]  # Luhn checksum
    return sum(d[0::2] + [sum(divmod(2 * x, 10)) for x in d[1::2]]) % 10 == 0
# Test cases
print(is_valid_credit_card("4111-1111-1111-1111"))
# Output: True
print(is_valid_credit_card("4012-3456-7890-1234"))
# Output: False
print(is_valid_credit_card("1234-5678-9012-3456"))
# Output: False
```

```text
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: This checks the format only, with no Luhn checksum. The book's "valid" example `4012-3456-7890-1234` fails Luhn.
>
> Original book code (do not use):
>
> ```python
> import re
> def is_valid_credit_card(card):
>     regex = re.compile(r'^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13})$')
>     return bool(regex.match(card.replace("-", "")))
> # Test cases
> print(is_valid_credit_card("4012-3456-7890-1234"))
> # Output: True
> print(is_valid_credit_card("1234-5678-9012-3456"))
> # Output: False
> ```


### 179. Calculate the Perimeter of a Triangle

The triangle_perimeter function calculates the perimeter of a triangle.

```python
def triangle_perimeter(side1, side2, side3):
    return side1 + side2 + side3
# Test case
print(triangle_perimeter(5, 10, 7))
# Output: 22
```

```text
22
```


### 180. Check if a Number is a Vampire Number

The is_vampire_number function checks is a number is a vampire number.

```python
def is_vampire_number(num):
    num_str = str(num)
    n = len(num_str)
    if n % 2:
        return False
    for factor1 in range(10 ** (n // 2 - 1), int(num ** 0.5) + 1):
        if num % factor1 == 0:
            factor2 = num // factor1
            if (len(str(factor2)) == n // 2  # fangs have n/2 digits each
                    and not (factor1 % 10 == 0 and factor2 % 10 == 0)  # not both ending in 0
                    and sorted(str(factor1) + str(factor2)) == sorted(num_str)):
                return True
    return False
# Test cases
print(is_vampire_number(1260))
# Output: True
print(is_vampire_number(1250))
# Output: False
print([n for n in range(1000, 10000) if is_vampire_number(n)])
# Output: [1260, 1395, 1435, 1530, 1827, 2187, 6880]
```

```text
True
False
[1260, 1395, 1435, 1530, 1827, 2187, 6880]
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Once indentation is restored (`return False` after the loop) the example works. It doesn't enforce the vampire rules that both fangs have n/2 digits and don't both end in 0, so 126000 = 210 x 600 passes.
>
> Original book code (do not use):
>
> ```python
> def is_vampire_number(num):
>     num_str = str(num)
>     num_len = len(num_str)
>     for factor1 in range(10 ** (num_len // 2 - 1), int(num ** 0.5) + 1):
>         if num % factor1 == 0:
>             factor2 = num // factor1
>             if sorted(str(factor1) + str(factor2)) == sorted(num_str):
>                 return True
>     return False
> # Test cases
> print(is_vampire_number(1260))
> # Output: True
> print(is_vampire_number(1250))
> # Output: False
> ```


### 181. Obsolete Sum Converter

The get_abs_sum the absolute sum of integers in an array.

```python
def get_abs_sum(arr):
    return sum(abs(num) for num in arr)
# Test case
arr = [2, -1, 4, 8, 10]
print(get_abs_sum(arr))
# Output: 25
```

```text
25
```


### 182. Check if a Number is a Duck Number

The is_duck_number function checks whether a given number is a duck number.

```python
def is_duck_number(num):
    num_str = str(num)
    return '0' in num_str and num_str[0] != '0'
# Test cases
print(is_duck_number(1023))
# Output: True
print(is_duck_number(12345))
# Output: False
```

```text
True
False
```


### 183. Generate a Random Password

The random_password function generates a random password of the specified length by creating an array of random alphanumeric characters and joining them together into a string.

<!-- nondeterministic -->
```python
import random
import string
def random_password(length):
    chars = string.ascii_letters + string.digits
    return ''.join(random.choice(chars) for _ in range(length))
# Test case
print(random_password(8))
# Output (varies), e.g.: 2yW4Acq9
```

```text
2yW4Acq9
```


### 184. Calculate the Area of a Trapezoid

The trapezoid_area function calculates the area of a trapezoid.

```python
def trapezoid_area(base1, base2, height):
    return 0.5 * (base1 + base2) * height
# Test case
print(trapezoid_area(4, 8, 6))
# Output: 36.0
```

```text
36.0
```

> [!NOTE]
> **Output comment corrected.** `0.5 * ...` is a float, so it prints `36.0`.


### 185. Check if a Number is a Kaprekar Number

The is_kaprekar_number function checks if a given number is a Kaprekar number.

```python
def is_kaprekar_number(num):
    square_str = str(num ** 2)
    r = len(str(num))
    left = int(square_str[:-r] or 0)   # the remaining (left) digits
    right = int(square_str[-r:])       # the last len(num) digits
    return num == 1 or (right > 0 and left + right == num)
# Test cases
print(is_kaprekar_number(9))
# Output: True
print(is_kaprekar_number(297))
# Output: True
print(is_kaprekar_number(45))
# Output: True
print(is_kaprekar_number(10))
# Output: False
```

```text
True
True
True
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Wrong split: the left part must be the *remaining* digits. 297^2 = 88209 -> 88 + 209 = 297 is Kaprekar (code: `False`), and 45^2 = 2025 -> 20 + 25 = 45 is Kaprekar too (book: `False`).
>
> Original book code (do not use):
>
> ```python
> def is_kaprekar_number(num):
>     square = num ** 2
>     square_str = str(square)
>     num_str = str(num)
>     left = int(square_str[:len(num_str)])
>     right = int(square_str[-len(num_str):])
>     return left + right == num
> # Test cases
> print(is_kaprekar_number(9))
> # Output: True
> print(is_kaprekar_number(297))
> # Output: True
> print(is_kaprekar_number(45))
> # Output: False
> ```


### 186. Calculate the Volume of a Cone

The cone_volume function calculates the volume of a cone.

```python
import math
def cone_volume(radius, height):
    return (1 / 3) * math.pi * radius ** 2 * height
# Test case
print(cone_volume(5, 10))
# Output: 261.79938779914943
```

```text
261.79938779914943
```


### 187. Check if a String is a Valid US Phone Number

The is_valid_us_phone_number function checks if a given string represents a valid US phone number.

```python
import re
def is_valid_us_phone_number(phone):
    pattern = r"^(?:(?:\+1\s?)?(?:\(?\d{3}\)?[\s.-]?)?\d{3}[\s.-]?\d{4})$"
    return bool(re.match(pattern, phone))
# Test cases
print(is_valid_us_phone_number("+1 (123) 456-7890"))
# Output: True
print(is_valid_us_phone_number("123-456-7890"))
# Output: True
print(is_valid_us_phone_number("1-800-ABC-DEFG"))
# Output: False
```

```text
True
True
False
```


### 188. Sastry Number Checker

The is_sastry function etermines whether a given positive integer n is a Sastry number.

```python
import math
def is_sastry(num):
    return math.sqrt(int(str(num) + str(num + 1))) % 1 == 0
# Test cases
print(is_sastry(183))
# Output: True
print(is_sastry(184))
# Output: False
```

```text
True
False
```


### 189. Factor Chain Checker

The factor_chain function checks if an array forms a factor chain, where each element is a factor of the next consecutive element.

```python
def factor_chain(arr):
    return all(arr[i + 1] % arr[i] == 0 for i in range(len(arr) - 1))
# Test cases
chain1 = [1, 2, 4, 8, 16, 32]
chain2 = [2, 4, 6, 7, 12]
print(factor_chain(chain1))
# Output: True
print(factor_chain(chain2))
# Output: False
```

```text
True
False
```


### 190. Calculate Boxes in Algebra Sequence

The box_seq function takes a step number as input and calculates the number of boxes in that step of the algebra sequence. Each step increases the number of boxes by either 0 or 2, depending on whether the step number is even or odd, respectively.

```python
def box_seq(step):
    return step + (step % 2 * 2)
# Example usage:
print(box_seq(5))
# Output: 7
print(box_seq(0))
# Output: 0
print(box_seq(10))
# Output: 10
```

```text
7
0
10
```


### 191. Calculate the Volume of a Cuboid

The cuboid_volume function calculates the volume of a cuboid.

```python
def cuboid_volume(length, width, height):
    return length * width * height
# Example usage:
length = 5
width = 10
height = 8
volume = cuboid_volume(length, width, height)
print("Volume of the cuboid:", volume)
# Output: Volume of the cuboid: 400
```

```text
Volume of the cuboid: 400
```


### 192. Triangular Number Sequence

The triangular calculates the nth triangular number in the triangular number sequence. A triangular number is the sum of all positive integers up to a given integer n.

```python
def triangular(n):
    return n * (n + 1) // 2
# Example usage:
print(triangular(1))
# Output: 1
print(triangular(2))
# Output: 3
print(triangular(3))
# Output: 6
print(triangular(4))
# Output: 10
print(triangular(5))
# Output: 15
```

```text
1
3
6
10
15
```


### 193. Generate a Random Color (Hexadecimal Format)

The random_color_hex function generates a random color (hexadecimal format)

<!-- nondeterministic -->
```python
import random
def random_color_hex():
    return '#{0:06x}'.format(random.randint(0, 0xFFFFFF))
# Example usage:
print(random_color_hex())
# Output (varies), e.g.: #c53edf
```

```text
#c53edf
```


### 194. Calculate the Area of a Circle Sector

The circle_sector_area function calculates the area of a circle sector.

```python
import math
def circle_sector_area(radius, angle):
    return (angle / 360) * math.pi * radius ** 2
# Example usage:
print(circle_sector_area(5, 90))
# Output: 19.634954084936208
```

```text
19.634954084936208
```

> [!NOTE]
> **Output comment corrected.** Python prints `19.634954084936208`.


### 195. Calculate the Area of a Regular Polygon

The regular_polygon_area function calculates the area of a regular polygon.

```python
import math
def regular_polygon_area(side_length, num_of_sides):
    return (num_of_sides * side_length ** 2) / (4 * math.tan(math.pi / num_of_sides))
# Example usage:
print(regular_polygon_area(5, 6))
# Output: 64.9519052838329
```

```text
64.9519052838329
```


### 196. Remove Duplicates from Array

The remove_duplicates function removes duplicates from array.

```python
def remove_duplicates(arr):
    return list(dict.fromkeys(arr))
# Example usage:
array = [1, 2, 3, 3, 4, 4, 5, 5, 6]
result = remove_duplicates(array)
print(", ".join(map(str, result)))
# Output: 1, 2, 3, 4, 5, 6
```

```text
1, 2, 3, 4, 5, 6
```


### 197. Calculate the Area of an Ellipse

The ellipse_area function calculates the area of an ellipse.

```python
import math
def ellipse_area(a, b):
    return math.pi * a * b
# Example usage:
semi_major_axis = 5
semi_minor_axis = 10
area = ellipse_area(semi_major_axis, semi_minor_axis)
print(area)
# Output: 157.07963267948966
```

```text
157.07963267948966
```


### 198. Check if a Number is a Leyland Number

The is_leyland_number function checks if a number is a Leyland number.

```python
def is_leyland_number(num):
    # num = x**y + y**x with 1 < x <= y
    limit = num.bit_length() + 1
    return any(x ** y + y ** x == num for x in range(2, limit) for y in range(x, limit))
# Example usage:
print(is_leyland_number(17))
# Output: True
print(is_leyland_number(30))
# Output: False
print(is_leyland_number(100))
# Output: True
print(is_leyland_number(8))
# Output: True
```

```text
True
False
True
True
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `return False` goes after both loops.

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: With indentation restored, `30 -> False` and `100 -> True` (100 = 2^6 + 6^2). The book claims the opposite for both. `y` also starts at `x+1`, so the `x == y` cases (8, 54) are missed.
>
> Original book code (do not use):
>
> ```python
> def is_leyland_number(num):
>     for x in range(2, int(num ** (1/3)) + 1):
>         for y in range(x + 1, num // x + 1):
>             if x ** y + y ** x == num:
>                 return True
>     return False
> # Example usage:
> print(is_leyland_number(17))
> # Output: True
> print(is_leyland_number(30))
> # Output: True
> print(is_leyland_number(100))
> # Output: False
> ```


### 199. Generate a Random UUID

The random_uuid function generates a random UUID by substituting placeholders in the UUID template with random hexadecimal values.

<!-- nondeterministic -->
```python
import uuid
def random_uuid():
    return str(uuid.uuid4())
# Example usage:
print(random_uuid())
# Output (varies), e.g.: 159cdbd8-140e-4dbf-ad2d-6a897854ed14
```

```text
159cdbd8-140e-4dbf-ad2d-6a897854ed14
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: This isn't an RFC 4122 UUID: the variant nibble is random. Use `uuid.uuid4()`.
>
> Original book code (do not use):
>
> ```python
> import random
> import string
> def random_uuid():
>     random_hex = lambda length: ''.join(random.choice(string.hexdigits) for _ in range(length))
>     return f"{random_hex(8)}-{random_hex(4)}-4{random_hex(3)}-{random_hex(4)}-{random_hex(12)}".lower()
> # Example usage:
> print(random_uuid())
> # Output: a0f768f5-6bf2-4f6b-a512-c9121ea1b44a
> ```


### 200. Check if a String is a Valid IPv6 Address

The is_valid_ipv6 function checks is a string is a valid IPV6 address.

```python
import ipaddress
def is_valid_ipv6(ip):
    try:
        return isinstance(ipaddress.ip_address(ip), ipaddress.IPv6Address)
    except ValueError:
        return False
# Test cases
print(is_valid_ipv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334"))
# Output: True
print(is_valid_ipv6("2001:0db8:85a3::8a2e:0370:7334"))
# Output: True
print(is_valid_ipv6("256.0.0.0"))
# Output: False
```

```text
True
True
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Only the full 8-group form matches, so the compressed `2001:0db8:85a3::8a2e:0370:7334` returns `False` (book: `True`).
>
> Original book code (do not use):
>
> ```python
> import re
> def is_valid_ipv6(ip):
>     pattern = r"^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$"
>     return bool(re.match(pattern, ip))
> # Test cases
> print(is_valid_ipv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334"))
> # Output: True
> print(is_valid_ipv6("2001:0db8:85a3::8a2e:0370:7334"))
> # Output: True
> print(is_valid_ipv6("256.0.0.0"))
> # Output: False
> ```


## Entries 201–250

### 201. Calculate the Area of a Parallelogram

The parallelogram_area function calculates the area of a parallelogram.

```python
def parallelogram_area(base_length, height):
    return base_length * height
# Test case
print(parallelogram_area(5, 10))
# Output: 50
```

```text
50
```


### 202. Check if a String is a Valid MAC Address

The is_valid_mac_address function checks if a string is a valid MAC Address.

```python
import re
def is_valid_mac_address(mac):
    pattern = r'^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$'
    return bool(re.match(pattern, mac))
# Test cases
print(is_valid_mac_address("00:1A:2B:3C:4D:5E"))
# Output: True
print(is_valid_mac_address("00:1A:2B:3C:4D"))
# Output: False
```

```text
True
False
```


### 203. Convert RGB to HSL (Hue, Saturation, Lightness)

The rgb_to_hsl function converts an RGB color value to its corresponding HSL representation (Hue, Saturation, Lightness).

```python
import colorsys
def rgb_to_hsl(rgb):
    r, g, b = rgb
    h, l, s = colorsys.rgb_to_hls(r / 255.0, g / 255.0, b / 255.0)
    return h * 360, s * 100, l * 100
# Example usage:
rgb_value = (255, 0, 0) # Red color
hsl_value = rgb_to_hsl(rgb_value)
print(hsl_value)
# Output: (0.0, 100.0, 50.0)
```

```text
(0.0, 100.0, 50.0)
```


### 204. Check if a Number is a Pandigital Number

The is_pandigital_number function checks if a given number is a pandigital number.

```python
def is_pandigital_number(num):
    num_str = str(num)
    return len(set(num_str)) == len(num_str) and '0' not in num_str and max(num_str) == str(len(num_str))
# Test cases
print(is_pandigital_number(123456789))
# Output: True
print(is_pandigital_number(987654321))
# Output: True
print(is_pandigital_number(1023456789))
# Output: False
```

```text
True
True
False
```


### 205. Neutralize Strings Interaction

The neutralise function takes two strings composed of '+' and '-' characters and returns a new string that represents the interaction between the two input strings. If the characters at corresponding positions in both strings are the same, it adds that character to the output string. Otherwise, it adds '0' to the output string.

```python
def neutralise(s1, s2):
    return ''.join(c1 if c1 == c2 else '0' for c1, c2 in zip(s1, s2))
# Test case
s1 = "++-+"
s2 = "+-++"
print(neutralise(s1, s2))
# Output: +00+
```

```text
+00+
```


### 206. Convert Yen to USD

The yen_to_usd function converts Yen (Japanese currency) to USD (American currency) using the exchange rate of 1 USD = 107.5 Yen. It returns the converted amount rounded to two decimal places.

```python
def yen_to_usd(yen):
    return round(yen / 107.5, 2)
# Test case
yen_amount = 1000
print(yen_to_usd(yen_amount))
# Output: 9.3
```

```text
9.3
```


### 207. Calculate War of Numbers

The war_of_numbers takes an array of integers, sums up the even and odd numbers separately, and then subtracts the smaller sum from the larger one. It returns the absolute value of this subtraction.

```python
def war_of_numbers(arr):
    even_sum = sum(x for x in arr if x % 2 == 0)
    odd_sum = sum(x for x in arr if x % 2 != 0)
    return abs(even_sum - odd_sum)
# Test case
numbers = [1, 2, 3, 4, 5, 6]
print(war_of_numbers(numbers))
# Output: 3
```

```text
3
```


### 208. Calculate Iterated Square Root

The isqrt function that takes an integer as input and returns the number of times its iterated square root can be taken until the result is less than 2. If the input number is negative, it returns "invalid".

```python
import math
def isqrt(n):
    # iterated square root: how many square roots bring n strictly below 2
    if n < 0:
        return "invalid"
    count = 0
    while n >= 2:
        n = math.sqrt(n)
        count += 1
    return str(count)
# Example usage
print(isqrt(16))
# Output: 3
print(isqrt(25))
# Output: 3
print(isqrt(256))
# Output: 4
print(isqrt(-25))
# Output: invalid
```

```text
3
3
4
invalid
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Computes floor(log2(sqrt n)), not the iterated square root (how many square roots until the value drops below 2): 16 -> 4 -> 2 -> 1.41 takes 3.
>
> Original book code (do not use):
>
> ```python
> import math
> def isqrt(n):
>     if n < 0:
>         return "invalid"
>     else:
>         return str(int(math.log(math.sqrt(n), 2)))
> # Example usage
> print(isqrt(16)) # Output: 2
> print(isqrt(25)) # Output: 2
> print(isqrt(256)) # Output: 4
> print(isqrt(-25)) # Output: invalid
> ```


### 209. Determine Rock, Paper, Scissors Winner

The RPS function determines the winner in Rock, Paper, Scissors game.

```python
def rps(p1, p2):
    if p1 == p2:
        return "It's a draw"
    elif (p1 == "Rock" and p2 == "Scissors") or (p1 == "Scissors" and p2 == "Paper") or (p1 == "Paper" and p2 == "Rock"):
        return "The winner is p1"
    else:
        return "The winner is p2"
# Example usage
print(rps("Rock", "Paper"))
# Output: The winner is p2
print(rps("Scissors", "Paper"))
# Output: The winner is p1
print(rps("Rock", "Rock"))
# Output: It's a draw
```

```text
The winner is p2
The winner is p1
It's a draw
```


### 210. Replace Sausages with "Wurst”

"WURST” The wurst_is_better function takes a string representing a sentence or text containing various types of sausages.

```python
import re
def wurst_is_better(text):
    return re.sub(r'kielbasa|chorizo|moronga|salami|sausage|andouille|naem|merguez|gurka|snorkers|pepperoni', 'Wurst', text, flags=re.IGNORECASE)
# Example usage
input_text = "I love kielbasa, chorizo, and pepperoni pizza."
print(wurst_is_better(input_text))
# Output: I love Wurst, Wurst, and Wurst pizza.
```

```text
I love Wurst, Wurst, and Wurst pizza.
```


### 211. Update Ages After Years

The after_n_years function updates the ages of the people after a specified number of years have passed.

```python
def after_n_years(people, years):
    return {name: age + abs(years) for name, age in people.items()}
# Example usage
ages = {
    "John": 30,
    "Alice": 25,
    "Bob": 40
}
updated_ages = after_n_years(ages, 5)
for name, age in updated_ages.items():
    print(f"{name}: {age}")
# Output:
#   John: 35
#   Alice: 30
#   Bob: 45
```

```text
John: 35
Alice: 30
Bob: 45
```


### 212. Detect Syncopation in Music

The has_syncopation function takes a line of music represented as a string, where hashtags '#' represent emphasized beats, and determines if the line of music contains any syncopation, returning true if it does and false otherwise.

```python
def has_syncopation(s):
    return any(c == '#' for idx, c in enumerate(s) if idx % 2 == 1)
# Example usage
print(has_syncopation("#.#.#"))
# Output: False
print(has_syncopation("##.#.#"))
# Output: True
print(has_syncopation("###"))
# Output: True
```

```text
False
True
True
```

> [!NOTE]
> **Output comment corrected.** `'#.#.#'` returns `False` and `'###'` returns `True`, the opposite of the book for both.


### 213. Extend Vowels in a Word

The extend_vowels function extend the vowels in a word.

```python
import re
def extend_vowels(word, num):
    if num < 0 or not isinstance(num, int):
        return "invalid"
    return re.sub(r'[aeiouAEIOU]', lambda x: x.group(0) * (num + 1), word)
# Example usage
print(extend_vowels("hello", 2))
# Output: heeellooo
print(extend_vowels("world", -1))
# Output: invalid
```

```text
heeellooo
invalid
```

> [!NOTE]
> **Output comment corrected.** Each vowel is repeated `num+1` times, so `("hello", 2)` gives `heeellooo`. The book's `heellloo` can't come from this code.


### 214. Generate a Random Alphanumeric String

The random_alphanumeric_string function generates a random alphanumeric string.

<!-- nondeterministic -->
```python
import random
import string
def random_alphanumeric_string(length):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))
# Example usage
print(random_alphanumeric_string(8))
# Output (varies), e.g.: 0UAqFzWs
```

```text
0UAqFzWs
```


### 215. Calculate the Area of a Regular Hexagon

The regular_hexagon_area function calculates the area of a regular hexagon.

```python
import math
def regular_hexagon_area(side_length):
    return (3 * math.sqrt(3) * side_length ** 2) / 2
# Example usage
print(regular_hexagon_area(5))
# Output: 64.9519052838329
```

```text
64.9519052838329
```


### 216. Calculate Cube Diagonal from Volume

The cube_diagonal function takes the volume of a cube as input and returns the length of the cube's main diagonal, rounded to two decimal places. It uses the formula for the length of the diagonal of a cube, which is the cube root of the volume multiplied by the square root of 3.

```python
import math
def cube_diagonal(volume):
    return round(math.pow(volume, 1/3) * math.sqrt(3), 2)
# Example usage
volume = 27
print(cube_diagonal(volume))
# Output: 5.2
```

```text
5.2
```


### 217. BigInt Decimal String Formatter

The format_bigint accepts a BigInt and a desired number of decimals, returning a string representation with the correct precision.

```python
def format_bigint(big_number, decimals):
    big_number_str = str(big_number)
    return big_number_str[:len(big_number_str) - decimals] + "." + big_number_str[len(big_number_str) - decimals:]
# Example usage
number = 123456789012345678901234567890
num_decimals = 5
formatted_number = format_bigint(number, num_decimals)
print(formatted_number)
# Output: 1234567890123456789012345.67890
```

```text
1234567890123456789012345.67890
```

> [!NOTE]
> **Output comment corrected.** A 30-digit integer with 5 decimals gives `1234567890123456789012345.67890`. The book's value has the point in the wrong place.


### 218. Check if a Number is a Reversible Number

The is_reversible_number function checks if a number is a reversible number.

```python
def is_reversible_number(num):
    # n + reverse(n) must have only odd digits; no trailing zero (reverse would lose a digit)
    return num % 10 != 0 and all(int(d) % 2 for d in str(num + int(str(num)[::-1])))
# Test cases
print(is_reversible_number(36))
# Output: True
print(is_reversible_number(45))
# Output: True
print(is_reversible_number(10))
# Output: False
```

```text
True
True
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: Wrong definition. A reversible number is one where n + reverse(n) has only odd digits (36 + 63 = 99). The code compares against the digit sum, so 36 and 45 return `False`.
>
> Original book code (do not use):
>
> ```python
> def is_reversible_number(num):
>     return num + int(str(num)[::-1]) == sum(int(digit) for digit in str(num))
> # Test cases
> print(is_reversible_number(36))
> # Output: True
> print(is_reversible_number(45))
> # Output: True
> print(is_reversible_number(10))
> # Output: False
> ```


### 219. Calculate the Circumference of a Circle

The circle_circumference function calculates the circumference of a circle.

```python
import math
def circle_circumference(radius):
    return 2 * math.pi * radius
# Test case
print(circle_circumference(5))
# Output: 31.41592653589793
```

```text
31.41592653589793
```


### 220. Find the Shortest Word in a String

The shortest_word function finds the shortest word in a string.

```python
def shortest_word(string):
    return min(string.split(), key=len)
# Test case
print(shortest_word("This is a test sentence"))
# Output: a
```

```text
a
```


### 221. Find the Longest Word Length in a String

The longest_word_length function finds the longest word length in a string.

```python
def longest_word_length(string):
    return max(len(word) for word in string.split())
# Test case
print(longest_word_length("This is a test sentence"))
# Output: 8
```

```text
8
```


### 222. Find the Sum of Proper Divisors of a Number

The sum_of_proper_divisors function finds the sum of proper divisors of a number.

```python
def sum_of_proper_divisors(num):
    return sum(i for i in range(1, num) if num % i == 0)
# Test cases
print(sum_of_proper_divisors(28))
# Output: 28
print(sum_of_proper_divisors(12))
# Output: 16
```

```text
28
16
```


### 223. Check if a Number is a Unitary Perfect Number

The is_unitary_perfect_number function checks if a number is a unitary perfect number.

```python
def is_unitary_perfect_number(num):
    def gcd(a, b):
        return a if b == 0 else gcd(b, a % b)
    # unitary divisor d: gcd(d, num // d) == 1
    return num == sum(d for d in range(1, num) if num % d == 0 and gcd(d, num // d) == 1)
# Test cases
print(is_unitary_perfect_number(18))
# Output: False
print(is_unitary_perfect_number(28))
# Output: False
print(is_unitary_perfect_number(60))
# Output: True
print([n for n in range(2, 100) if is_unitary_perfect_number(n)])
# Output: [6, 60, 90]
```

```text
False
False
True
[6, 60, 90]
```

> [!NOTE]
> **PDF layout.** Indentation restored: `gcd` is nested inside the function.

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: It tests `gcd(num, i) == 1` instead of `gcd(d, num // d) == 1`, so the sum is always 1. 28 isn't unitary perfect: its unitary divisors 1, 4, 7 sum to 12. The book claims `True`.
>
> Original book code (do not use):
>
> ```python
> def is_unitary_perfect_number(num):
>     def gcd(a, b):
>         return a if b == 0 else gcd(b, a % b)
>     return num == sum(i for i in range(1, num) if num % i == 0 and gcd(num, i) == 1)
> # Test cases
> print(is_unitary_perfect_number(18))
> # Output: False
> print(is_unitary_perfect_number(28))
> # Output: True
> ```


### 224. Calculate the Perimeter of a Regular Polygon

The RegularPolygonPerimeter function calculates the perimeter of a regular polygon.

```python
def regular_polygon_perimeter(side_length, num_sides):
    return side_length * num_sides
# Test case
print(regular_polygon_perimeter(5, 6))
# Output: 30
```

```text
30
```


### 225. Calculate the Area of an Equilateral Triangle

The equilateral_triangle_area function calculates the area of an equilateral triangle.

```python
import math
def equilateral_triangle_area(side_length):
    return (math.sqrt(3) * side_length ** 2) / 4
# Test case
print(equilateral_triangle_area(5))
# Output: 10.825317547305483
```

```text
10.825317547305483
```

> [!NOTE]
> **Output comment corrected.** Python prints `10.825317547305483`.


### 226. Check if a Number is a Harshad Smith Number

The IsHarshadSmithNumber function checks if a given number is both a Harshad number and a Smith number.

```python
def is_harshad_smith_number(num):
    digit_sum = lambda n: sum(int(d) for d in str(n))
    factors, n, f = [], num, 2
    while f * f <= n:
        while n % f == 0:
            factors.append(f)
            n //= f
        f += 1
    if n > 1:
        factors.append(n)
    is_harshad = num % digit_sum(num) == 0
    is_smith = len(factors) > 1 and digit_sum(num) == sum(digit_sum(p) for p in factors)
    return is_harshad and is_smith
# Test cases
print(is_harshad_smith_number(22))
# Output: False
print(is_harshad_smith_number(27))
# Output: True
print(is_harshad_smith_number(10))
# Output: False
```

```text
False
True
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: It requires the number to be prime **and** equal to its own digit sum, so 22 returns `False` (book: `True`). 22 is a Smith number but not Harshad (22 % 4 != 0).
>
> Original book code (do not use):
>
> ```python
> def is_harshad_smith_number(num):
>     return all(num % i != 0 for i in range(2, int(num ** 0.5) + 1)) and sum(int(d) for d in str(num)) == num and sum(int(d) for d in str(num)) == sum(sum(int(d) for d in str(f)) for f in ([i for i in range(2, num) if num % i == 0]))
> # Test cases
> print(is_harshad_smith_number(22))
> # Output: True
> print(is_harshad_smith_number(10))
> # Output: False
> ```


### 227. Check if a Number is a Perfect Power

The is_perfect_power function checks if a number is a perfect power.

```python
def is_perfect_power(num):
    return any(base**exponent == num for base in range(2, int(num**0.5) + 1) for exponent in range(2, int(num**0.5) + 1))
# Test cases
print(is_perfect_power(64))
# Output: True
print(is_perfect_power(25))
# Output: True
```

```text
True
True
```

> [!NOTE]
> **Output comment corrected.** 25 = 5^2 *is* a perfect power. The code correctly returns `True`; the book claims `False`.


### 228. Drop Elements from Array

The drop function takes an array and an optional value indicating the number of elements to drop from the beginning of the array. It returns a new array containing the remaining elements after dropping the specified number of elements.

```python
def drop(arr, val=1):
    return arr[val:]
# Test cases
print(drop([1, 2, 3]))
# Output: [2, 3]
print(drop([1, 2, 3], 2))
# Output: [3]
print(drop([1, 2, 3], 5))
# Output: []
print(drop([1, 2, 3], 0))
# Output: [1, 2, 3]
print(drop(["banana", "orange", "watermelon", "mango"], 2))
# Output: ['watermelon', 'mango']
print(drop([], 2))
# Output: []
```

```text
[2, 3]
[3]
[]
[1, 2, 3]
['watermelon', 'mango']
[]
```


### 229. Maximum Total of Last Five Elements in an Array

The max_total function calculates the maximum total of the last five elements in an integer array.

```python
def max_total(nums):
    return sum(sorted(nums)[-5:])
# Test cases
print(max_total([1, 1, 0, 1, 3, 10, 10, 10, 10, 1]))
# Output: 43
print(max_total([0, 0, 0, 0, 0, 0, 0, 0, 0, 100]))
# Output: 100
print(max_total([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
# Output: 40
print(max_total([12, 8, 73, 1, 24, 11, 88, 39, 2, -47]))
# Output: 236
print(max_total([48, 90, 42, -12, 1, -14, -36, -37, -9, -4]))
# Output: 177
```

```text
43
100
40
236
177
```


### 230. Calculate the Area of a Regular Pentagon

The regular_pentagon_area function calculates the area of a regular pentagon.

```python
import math
def regular_pentagon_area(side_length):
    return (1 / 4) * math.sqrt(5 * (5 + 2 * math.sqrt(5))) * side_length ** 2
# Test case
print(regular_pentagon_area(5))
# Output: 43.01193501472417
```

```text
43.01193501472417
```


### 231. Calculate the Volume of a Pyramid

The pyramid_volume function calculates the volume of a pyramid.

```python
def pyramid_volume(base_area, height):
    return (1 / 3) * base_area * height
# Test case
print(pyramid_volume(25, 10))
# Output: 83.33333333333331
```

```text
83.33333333333331
```

> [!NOTE]
> **Output comment corrected.** Python prints `83.33333333333331`.


### 232. Check if a Number is a Wedderburn-Etherington Number

The is_wedderburn_etherington_number function checks if a given number is a Wedderburn-Etherington number.

```python
def is_wedderburn_etherington_number(num):
    a = [0, 1]  # OEIS A001190
    while a[-1] < num:
        m = len(a)
        if m % 2:  # a(2n-1) = sum a(i) a(2n-1-i), i = 1..n-1
            n = (m + 1) // 2
            a.append(sum(a[i] * a[m - i] for i in range(1, n)))
        else:      # a(2n) = a(n)(a(n)+1)/2 + sum a(i) a(2n-i), i = 1..n-1
            n = m // 2
            a.append(a[n] * (a[n] + 1) // 2 + sum(a[i] * a[m - i] for i in range(1, n)))
    return num in a
# Test cases
print(is_wedderburn_etherington_number(6))
# Output: True
print(is_wedderburn_etherington_number(12))
# Output: False
print([n for n in range(200) if is_wedderburn_etherington_number(n)])
# Output: [0, 1, 2, 3, 6, 11, 23, 46, 98]
```

```text
True
False
[0, 1, 2, 3, 6, 11, 23, 46, 98]
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `functools` and `operator` are never imported. It only runs because `and` short-circuits for composite numbers (any prime raises `NameError`). The math is also unrelated: 6 *is* a Wedderburn-Etherington number (0, 1, 1, 1, 2, 3, 6, 11, 23, 46, 98, ...).
>
> Original book code (do not use):
>
> ```python
> def is_wedderburn_etherington_number(num):
>     return all(num % i != 0 for i in range(2, num)) and \
> functools.reduce(operator.mul, (functools.reduce(operator.mul, range(1, n)) for n in range(2, num)), 1) == \
> functools.reduce(operator.mul, range(1, num), 1)
> # Test cases
> print(is_wedderburn_etherington_number(6))
> # Output: True
> print(is_wedderburn_etherington_number(12))
> # Output: False
> ```


### 233. Calculate the Surface Area of a Cube

The cube_surface_area function calculates the surface area of a cube.

```python
def cube_surface_area(side_length):
    return 6 * side_length ** 2
# Test case
print(cube_surface_area(5))
# Output: 150
```

```text
150
```


### 234. Find the Second Largest Number in an Array

The second_largest takes an array of numbers and returns the second largest number.

```python
def second_largest(arr):
    sorted_arr = sorted(arr, reverse=True)
    return sorted_arr[1]
# Test case
arr = [1, 3, 5, 7, 9]
print(second_largest(arr))
# Output: 7
```

```text
7
```


### 235. Calculate the Area of a Regular Octagon

The regular_octagon_area function calculates the area of a regular octagon.

```python
def regular_octagon_area(side_length):
    return 2 * (1 + 2 ** 0.5) * side_length ** 2
# Test
print(regular_octagon_area(5))
# Output: 120.71067811865474
```

```text
120.71067811865474
```

> [!NOTE]
> **Output comment corrected.** The book's `86.60...` is wrong: 2(1+sqrt 2) x 25 = 120.71.


### 236. Check if a Number is a Repunit Number

The is_repunit_number function checks if a number is a repunit number.

```python
import re
def is_repunit_number(num):
    return bool(re.match("^1+$", str(num)))
# Test
print(is_repunit_number(111))
# Output: True
print(is_repunit_number(11))
# Output: True
```

```text
True
True
```

> [!NOTE]
> **Output comment corrected.** 11 *is* a repunit. The code returns `True`; the book claims `False`.


### 237. Calculate the Volume of an Ellipsoid

The ellipsoid_volume function calculates the volume of an ellipsoid.

```python
import math
def ellipsoid_volume(a, b, c):
    return (4 / 3) * math.pi * a * b * c
# Test
print(ellipsoid_volume(5, 3, 2))
# Output: 125.66370614359171
```

```text
125.66370614359171
```

> [!NOTE]
> **Output comment corrected.** Python prints `125.66370614359171`.


### 238. Check if a String is a Valid URL

The is_valid_url_alt function checks if a given string is a valid URL using an alternative approach.

```python
import re
def is_valid_url_alt(url):
    return bool(re.match(r"^(ftp|http|https):\/\/[^ ]+$", url))
# Test
print(is_valid_url_alt("https://www.example.com"))
# Output: True
print(is_valid_url_alt("invalid url"))
# Output: False
```

```text
True
False
```


### 239. Check if a String is a Valid Tax Identification Number (TIN)

The is_valid_tin function check if a given string is a valid Tax Identification Number (TIN).

```python
import re
def is_valid_tin(tin):
    # US Taxpayer Identification Number: SSN (123-45-6789) or EIN (12-3456789)
    return bool(re.fullmatch(r"\d{3}-\d{2}-\d{4}|\d{2}-\d{7}", tin))
# Test
print(is_valid_tin("12-3456789"))
# Output: True
print(is_valid_tin("123-45-6789"))
# Output: True
print(is_valid_tin("AB123456CD"))
# Output: False
print(is_valid_tin("invalid tin"))
# Output: False
```

```text
True
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: The pattern `AA999999XX` is invented; real TIN formats are country-specific.
>
> Original book code (do not use):
>
> ```python
> import re
> def is_valid_tin(tin):
>     return bool(re.match(r"^[A-Z]{2}\d{6}[A-Z\d]{2}$", tin))
> # Test
> print(is_valid_tin("AB123456CD"))
> # Output: True
> print(is_valid_tin("invalid tin"))
> # Output: False
> ```


### 240. Check if a String is a Valid ISBN (International Standard Book Number)

The is_valid_isbn function checks if a given string is a valid International Standard Book Number (ISBN).

```python
def is_valid_isbn(isbn):
    s = isbn.replace("-", "").replace(" ", "")
    if len(s) == 10 and s[:9].isdigit() and (s[9].isdigit() or s[9] in "Xx"):
        return sum((10 - i) * (10 if c in "Xx" else int(c)) for i, c in enumerate(s)) % 11 == 0
    if len(s) == 13 and s.isdigit():
        return sum(int(c) * (3 if i % 2 else 1) for i, c in enumerate(s)) % 10 == 0
    return False
# Test
print(is_valid_isbn("0-306-40615-2"))
# Output: True
print(is_valid_isbn("978-0-306-40615-7"))
# Output: True
print(is_valid_isbn("123456789"))
# Output: False
print(is_valid_isbn("invalid isbn"))
# Output: False
```

```text
True
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `'123456789'` has 9 characters and ISBN-10 has 10, so the code returns `False` (book: `True`). There's no check-digit validation either.
>
> Original book code (do not use):
>
> ```python
> import re
> def is_valid_isbn(isbn):
>     return bool(re.match(r"^(?:\d{9}[\dX]|(?:\d{3}-){2}\d{1}[\dX])$", isbn))
> # Test
> print(is_valid_isbn("123456789"))
> # Output: True
> print(is_valid_isbn("invalid isbn"))
> # Output: False
> ```


### 241. Check if a String is a Valid IP Address

The is_valid_ip_address function checks if a given string is a valid IP address.

```python
import ipaddress
def is_valid_ip_address(ip):
    try:
        ipaddress.ip_address(ip)  # strict IPv4 or IPv6
        return True
    except ValueError:
        return False
# Test
print(is_valid_ip_address("192.168.1.1"))
# Output: True
print(is_valid_ip_address("invalid ip"))
# Output: False
print(is_valid_ip_address("127.1"))
# Output: False
```

```text
True
False
False
```

> [!IMPORTANT]
> **Corrected.** What was wrong in the book's version: `inet_aton` accepts shorthand such as `'127.1'` and `'1'`. `ipaddress.ip_address` is strict.
>
> Original book code (do not use):
>
> ```python
> import socket
> def is_valid_ip_address(ip):
>     try:
>         socket.inet_aton(ip)
>         return True
>     except socket.error:
>         return False
> # Test
> print(is_valid_ip_address("192.168.1.1"))
> # Output: True
> print(is_valid_ip_address("invalid ip"))
> # Output: False
> ```


### 242. Reverse a String (Using Recursion)

The ReverseStringRecursive function reverse a string (using recursion).

```python
def reverse_string_recursive(s):
    return s if len(s) <= 1 else reverse_string_recursive(s[1:]) + s[0]
# Test
print(reverse_string_recursive("hello"))
# Output: olleh
```

```text
olleh
```


### 243. Count the Occurrences of Each Element in an Array

The count_occurrences function counts the occurrences of each element in an array.

```python
from collections import Counter
def count_occurrences(arr):
    return dict(Counter(arr))
# Test
print(count_occurrences([1, 2, 1, 3, 2, 4, 1]))
# Output: {1: 3, 2: 2, 3: 1, 4: 1}
```

```text
{1: 3, 2: 2, 3: 1, 4: 1}
```


### 244. Check if Two Arrays are Equal

The arrays_are_equal function checks if two arrays are equal (shallow comparison).

```python
def arrays_are_equal(arr1, arr2):
    return arr1 == arr2
# Test
print(arrays_are_equal([1, 2, 3], [1, 2, 3]))
# Output: True
print(arrays_are_equal([1, 2, 3], [1, 2, 4]))
# Output: False
```

```text
True
False
```


### 245. Find the Minimum Value in an Array

The function find_min_value finds the minimum value in a given array of numbers.

```python
def find_min_value(arr):
    return min(arr)
# Test
numbers = [2, 7, 1, 9, 4]
print(find_min_value(numbers))
# Output: 1
```

```text
1
```


### 246. Flatten an Array of Nested Arrays

The flatten_array function flatten an array of nested arrays (using concat).

```python
def flatten_array(arr):
    return [item for sublist in arr for item in sublist]
# Test
nested_arrays = [[1, 2], [3, 4], [5, 6]]
print(", ".join(map(str, flatten_array(nested_arrays))))
# Output: 1, 2, 3, 4, 5, 6
```

```text
1, 2, 3, 4, 5, 6
```


### 247. Find the Average of Numbers in an Array

The find_average function finds the average of numbers in an array.

```python
def find_average(arr):
    return sum(arr) / len(arr)
# Test
numbers = [1, 2, 3, 4, 5]
print(find_average(numbers))
# Output: 3.0
```

```text
3.0
```


### 248. Sum the Squares of Numbers in an Array

The SumSquares function sum the squares of numbers in an array.

```python
def sum_squares(arr):
    return sum(num * num for num in arr)
# Test
numbers = [1, 2, 3, 4, 5]
print(sum_squares(numbers))
# Output: 55
```

```text
55
```


### 249. Check if a String is a Palindrome (Ignoring Non-Alphanumeric Characters)

The is_palindrome_ignoring_non_alphanum eric function checks if a string is a palindrome (ignoring non-alphanumeric characters).

```python
import re
def is_palindrome_ignoring_non_alphanumeric(s):
    # Remove non-alphanumeric characters and convert to lowercase
    cleaned_str = re.sub(r'[^a-z0-9]', '', s.lower())
    # Check if the cleaned string is equal to its reversed version
    return cleaned_str == cleaned_str[::-1]
# Test
print(is_palindrome_ignoring_non_alphanumeric("A man, a plan, a canal, Panama!"))
# Output: True
```

```text
True
```


### 250. Find Bob in a List

The find_bob function takes an array of strings representing names and returns the index of the name "Bob" in the array. If "Bob" is not found, it returns -1.

```python
def find_bob(names):
    try:
        return names.index("Bob")
    except ValueError:
        return -1
# Test cases
names1 = ["Jimmy", "Layla", "Mandy"]
names2 = ["Bob", "Nathan", "Hayden"]
names3 = ["Paul", "Layla", "Bob"]
names4 = ["Garry", "Maria", "Bethany", "Bob", "Pauline"]
print(find_bob(names1))
# Output: -1
print(find_bob(names2))
# Output: 0
print(find_bob(names3))
# Output: 2
print(find_bob(names4))
# Output: 3
```

```text
-1
0
2
3
```


## Entries 251–264

### 251. Calculate The Volume of a Box

The box_volume function calculates the volume of a box.

```python
def box_volume(length, width, height):
    return length * width * height
# Test case
length = 5
width = 3
height = 2
volume = box_volume(length, width, height)
print(f"Volume of the box: {volume}")
# Output: Volume of the box: 30
```

```text
Volume of the box: 30
```


### 252. Move Zeros to the End

The move_zeros function converts the given array such that all the zeros are moved to the end while maintaining the order of the non-zero elements.

```python
def move_zeros(arr):
    non_zero_elements = [x for x in arr if x != 0]
    zero_count = arr.count(0)
    return non_zero_elements + [0] * zero_count
# Test cases
result = move_zeros([1, 2, 0, 1, 0, 1, 0, 3, 0, 1])
print(','.join(map(str, result)))
# Output: 1,2,1,1,3,1,0,0,0,0
result = move_zeros([9, 0, 0, 9, 1, 2, 0, 1, 0, 1, 0, 3, 0, 1, 9, 0, 0, 0, 0, 9])
print(','.join(map(str, result)))
# Output: 9,9,1,2,1,1,3,1,9,9,0,0,0,0,0,0,0,0,0,0
# Additional test cases here...
```

```text
1,2,1,1,3,1,0,0,0,0
9,9,1,2,1,1,3,1,9,9,0,0,0,0,0,0,0,0,0,0
```


### 253. Find the Median of Numbers in an Array

The find_median function finds the median of numbers in an array.

```python
def find_median(arr):
    sorted_arr = sorted(arr)
    middle = len(sorted_arr) // 2
    return (sorted_arr[middle] + sorted_arr[~middle]) / 2 if len(sorted_arr) % 2 == 0 else sorted_arr[middle]
# Test case
print(find_median([1, 3, 2, 4, 5]))
# Output: 3
```

```text
3
```


### 254. Count the Vowels in a String

The count_vowels function counts the vowels in a string.

```python
import re
def count_vowels(string):
    return len(re.findall(r'[aeiouAEIOU]', string))
# Test case
print(count_vowels("Hello, how are you?"))
# Output: 7
```

```text
7
```


### 255. Calculate Vote Difference

The get_vote_count function takes a dynamic object representing the votes, extracts the upvote and downvote counts, and returns the difference between them.

```python
def get_vote_count(votes):
    return (votes.get('upvotes', 0) or 0) - (votes.get('downvotes', 0) or 0)
# Test cases
print(get_vote_count({'upvotes': 13, 'downvotes': 0}))
# Output: 13
print(get_vote_count({'upvotes': 2, 'downvotes': 33}))
# Output: -31
print(get_vote_count({'upvotes': 132, 'downvotes': 132}))
# Output: 0
print(get_vote_count({'upvotes': 0, 'downvotes': 0}))
# Output: 0
print(get_vote_count({'downvotes': 4, 'upvotes': 1}))
# Output: -3
```

```text
13
-31
0
0
-3
```


### 256. Chatroom Status

The chatroom_status determines the status of a chatroom based on the number of users online. If there are no users, it returns "no one online". If there is only one user, it returns their username followed by "online". If there are two users, it returns both usernames followed by "online". If there are more than two users, it returns the usernames of the first two users followed by the count of remaining users and "more online".

```python
def chatroom_status(users):
    return "no one online" if not users else f"{users[0]} online" if len(users) == 1 else f"{users[0]} and {users[1]} online" if len(users) == 2 else f"{users[0]}, {users[1]} and {len(users) - 2} more online"
# Test cases
print(chatroom_status([]))
# Output: no one online
print(chatroom_status(["becky325"]))
# Output: becky325 online
print(chatroom_status(["becky325", "malcolm888"]))
# Output: becky325 and malcolm888 online
print(chatroom_status(["becky325", "malcolm888", "fah32fa"]))
# Output: becky325, malcolm888 and 1 more online
print(chatroom_status(["paRIE_to"]))
# Output: paRIE_to online
print(chatroom_status(["s234f", "mailbox2"]))
# Output: s234f and mailbox2 online
print(chatroom_status(["pap_ier44", "townieBOY", "panda321", "motor_bike5", "sandwichmaker833", "violinist91"]))
# Output: pap_ier44, townieBOY and 4 more online
```

```text
no one online
becky325 online
becky325 and malcolm888 online
becky325, malcolm888 and 1 more online
paRIE_to online
s234f and mailbox2 online
pap_ier44, townieBOY and 4 more online
```


### 257. Find the ASCII Value of a Character

The get_ascii_value function finds the ASCII value of a character.

```python
def get_ascii_value(c):
    return ord(c)
# Test case
print(get_ascii_value('A'))
# Output: 65
```

```text
65
```


### 258. Check if a String is an Isogram (No Repeating Characters)

The IsIsogram function checks if a string is an isogram (no repeating characters)

```python
def is_isogram(string):
    return len(set(string.lower())) == len(string)
# Test cases
print(is_isogram("hello"))
# Output: False
print(is_isogram("world"))
# Output: True
```

```text
False
True
```


### 259. Calculate the Hamming Distance of Two Strings (Equal Length)

The hamming_distance function calculates the hamming distance of two strings (equal length).

```python
def hamming_distance(str1, str2):
    if len(str1) != len(str2):
        raise ValueError("Strings must have equal length")
    return sum(c1 != c2 for c1, c2 in zip(str1, str2))
# Test case
print(hamming_distance("karolin", "kathrin"))
# Output: 3
```

```text
3
```


### 260. Calculate the Distance between Two Points in a 2D Plane

The calculate_distance function calculates the distance between two points in a 2D plane.

```python
import math
def calculate_distance(point1, point2):
    x1, y1 = point1
    x2, y2 = point2
    return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
# Test case
print(calculate_distance([0, 0], [3, 4]))
# Output: 5.0
```

```text
5.0
```

> [!NOTE]
> **Output comment corrected.** `math.sqrt` returns a float, so it prints `5.0`.


### 261. Check if a String is a Positive Number (No Sign or Decimal Allowed)

The is_positive_number function checks if a string is a positive number (no sign or decimal allowed)

```python
import re
def is_positive_number(string):
    return bool(re.match(r'^\d+$', string))
# Test cases
print(is_positive_number("123"))
# Output: True
print(is_positive_number("-123"))
# Output: False
```

```text
True
False
```


### 262. Find the First Non-Repeating Character in a String

The find_first_non_repeating_character function finds the first non-repeating character in a string.

```python
def find_first_non_repeating_character(string):
    for char in string:
        if string.count(char) == 1:
            return char
    return None # Return None if no non-repeating character is found
# Test case
print(find_first_non_repeating_character("hello"))
# Output: h
```

```text
h
```

> [!NOTE]
> **PDF layout.** Indentation restored: the `return None` goes after the loop.


### 263. Calculate the Area of a Kite

The area_of_kite function calculates the area of a kite.

```python
def area_of_kite(d1, d2):
    return 0.5 * d1 * d2
# Test case
print(f"Area of the kite: {area_of_kite(10, 6)}")
# Output: Area of the kite: 30.0
```

```text
Area of the kite: 30.0
```


### 264. Calculate the Area of a Sector

The sector_area function calculates the area of a sector within a circle based on the provided radius and angle.

```python
import math
def sector_area(radius, angle):
    return math.pi * radius**2 * angle / 360.0
# Test case
print(f"Area of the sector: {sector_area(5, 60)}")
# Output: Area of the sector: 13.08996938995747
```

```text
Area of the sector: 13.08996938995747
```

> [!NOTE]
> **Output comment corrected.** The book's `5.2359...` is wrong: pi x 25 x 60 / 360 = 13.09.

