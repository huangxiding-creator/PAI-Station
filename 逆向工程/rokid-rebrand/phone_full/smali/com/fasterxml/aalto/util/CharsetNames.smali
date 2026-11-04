.class public final Lcom/fasterxml/aalto/util/CharsetNames;
.super Ljava/lang/Object;
.source "CharsetNames.java"

# interfaces
.implements Lcom/fasterxml/aalto/util/XmlConsts;


# static fields
.field public static final CS_EBCDIC:Ljava/lang/String; = "EBCDIC"

.field public static final CS_ISO_LATIN1:Ljava/lang/String; = "ISO-8859-1"

.field public static final CS_SHIFT_JIS:Ljava/lang/String; = "Shift_JIS"

.field public static final CS_US_ASCII:Ljava/lang/String; = "US-ASCII"

.field public static final CS_UTF16:Ljava/lang/String; = "UTF-16"

.field public static final CS_UTF16BE:Ljava/lang/String; = "UTF-16BE"

.field public static final CS_UTF16LE:Ljava/lang/String; = "UTF-16LE"

.field public static final CS_UTF32:Ljava/lang/String; = "UTF-32"

.field public static final CS_UTF32BE:Ljava/lang/String; = "UTF-32BE"

.field public static final CS_UTF32LE:Ljava/lang/String; = "UTF-32LE"

.field public static final CS_UTF8:Ljava/lang/String; = "UTF-8"

.field private static final EOS:I = 0x10000


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static encodingStartsWith(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 12
    .param p0, "enc"    # Ljava/lang/String;
    .param p1, "prefix"    # Ljava/lang/String;

    .line 302
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 303
    .local v0, "len1":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 305
    .local v1, "len2":I
    const/4 v2, 0x0

    .local v2, "i1":I
    const/4 v3, 0x0

    .line 308
    .local v3, "i2":I
    :goto_0
    const/4 v4, 0x1

    if-lt v2, v0, :cond_1

    if-ge v3, v1, :cond_0

    goto :goto_1

    .line 339
    :cond_0
    return v4

    .line 309
    :cond_1
    :goto_1
    const/high16 v5, 0x10000

    if-lt v2, v0, :cond_2

    move v6, v2

    move v2, v5

    goto :goto_2

    :cond_2
    add-int/lit8 v6, v2, 0x1

    .end local v2    # "i1":I
    .local v6, "i1":I
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 310
    .local v2, "c1":I
    :goto_2
    if-lt v3, v1, :cond_3

    move v7, v3

    move v3, v5

    goto :goto_3

    :cond_3
    add-int/lit8 v7, v3, 0x1

    .end local v3    # "i2":I
    .local v7, "i2":I
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 313
    .local v3, "c2":I
    :goto_3
    if-ne v2, v3, :cond_4

    .line 314
    move v2, v6

    move v3, v7

    goto :goto_0

    .line 318
    :cond_4
    :goto_4
    const/16 v8, 0x20

    if-le v2, v8, :cond_c

    const/16 v9, 0x5f

    if-eq v2, v9, :cond_c

    const/16 v10, 0x2d

    if-ne v2, v10, :cond_5

    goto :goto_8

    .line 321
    :cond_5
    :goto_5
    if-le v3, v8, :cond_a

    if-eq v3, v9, :cond_a

    if-ne v3, v10, :cond_6

    goto :goto_6

    .line 325
    :cond_6
    if-eq v2, v3, :cond_9

    .line 326
    if-ne v3, v5, :cond_7

    .line 327
    return v4

    .line 329
    :cond_7
    const/4 v4, 0x0

    if-ne v2, v5, :cond_8

    .line 330
    return v4

    .line 332
    :cond_8
    int-to-char v5, v2

    invoke-static {v5}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v5

    int-to-char v8, v3

    invoke-static {v8}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v8

    if-eq v5, v8, :cond_9

    .line 333
    return v4

    .line 336
    .end local v2    # "c1":I
    .end local v3    # "c2":I
    :cond_9
    move v2, v6

    move v3, v7

    goto :goto_0

    .line 322
    .restart local v2    # "c1":I
    .restart local v3    # "c2":I
    :cond_a
    :goto_6
    if-lt v7, v1, :cond_b

    move v11, v7

    move v7, v5

    goto :goto_7

    :cond_b
    add-int/lit8 v11, v7, 0x1

    .end local v7    # "i2":I
    .local v11, "i2":I
    invoke-virtual {p1, v7}, Ljava/lang/String;->charAt(I)C

    move-result v7

    :goto_7
    move v3, v7

    move v7, v11

    goto :goto_5

    .line 319
    .end local v11    # "i2":I
    .restart local v7    # "i2":I
    :cond_c
    :goto_8
    if-lt v6, v0, :cond_d

    move v8, v6

    move v6, v5

    goto :goto_9

    :cond_d
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i1":I
    .local v8, "i1":I
    invoke-virtual {p0, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    :goto_9
    move v2, v6

    move v6, v8

    goto :goto_4
.end method

.method public static equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 11
    .param p0, "str1"    # Ljava/lang/String;
    .param p1, "str2"    # Ljava/lang/String;

    .line 262
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 263
    .local v0, "len1":I
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v1

    .line 265
    .local v1, "len2":I
    const/4 v2, 0x0

    .local v2, "i1":I
    const/4 v3, 0x0

    .line 268
    .local v3, "i2":I
    :goto_0
    if-lt v2, v0, :cond_1

    if-ge v3, v1, :cond_0

    goto :goto_1

    .line 297
    :cond_0
    const/4 v4, 0x1

    return v4

    .line 269
    :cond_1
    :goto_1
    const/high16 v4, 0x10000

    if-lt v2, v0, :cond_2

    move v5, v2

    move v2, v4

    goto :goto_2

    :cond_2
    add-int/lit8 v5, v2, 0x1

    .end local v2    # "i1":I
    .local v5, "i1":I
    invoke-virtual {p0, v2}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 270
    .local v2, "c1":I
    :goto_2
    if-lt v3, v1, :cond_3

    move v6, v3

    move v3, v4

    goto :goto_3

    :cond_3
    add-int/lit8 v6, v3, 0x1

    .end local v3    # "i2":I
    .local v6, "i2":I
    invoke-virtual {p1, v3}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 273
    .local v3, "c2":I
    :goto_3
    if-ne v2, v3, :cond_4

    .line 274
    move v2, v5

    move v3, v6

    goto :goto_0

    .line 278
    :cond_4
    :goto_4
    const/16 v7, 0x20

    if-le v2, v7, :cond_c

    const/16 v8, 0x5f

    if-eq v2, v8, :cond_c

    const/16 v9, 0x2d

    if-ne v2, v9, :cond_5

    goto :goto_9

    .line 281
    :cond_5
    :goto_5
    if-le v3, v7, :cond_a

    if-eq v3, v8, :cond_a

    if-ne v3, v9, :cond_6

    goto :goto_7

    .line 285
    :cond_6
    if-eq v2, v3, :cond_9

    .line 287
    const/4 v7, 0x0

    if-eq v2, v4, :cond_8

    if-ne v3, v4, :cond_7

    goto :goto_6

    .line 290
    :cond_7
    int-to-char v4, v2

    invoke-static {v4}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v4

    int-to-char v8, v3

    invoke-static {v8}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v8

    if-eq v4, v8, :cond_9

    .line 291
    return v7

    .line 288
    :cond_8
    :goto_6
    return v7

    .line 294
    .end local v2    # "c1":I
    .end local v3    # "c2":I
    :cond_9
    move v2, v5

    move v3, v6

    goto :goto_0

    .line 282
    .restart local v2    # "c1":I
    .restart local v3    # "c2":I
    :cond_a
    :goto_7
    if-lt v6, v1, :cond_b

    move v10, v6

    move v6, v4

    goto :goto_8

    :cond_b
    add-int/lit8 v10, v6, 0x1

    .end local v6    # "i2":I
    .local v10, "i2":I
    invoke-virtual {p1, v6}, Ljava/lang/String;->charAt(I)C

    move-result v6

    :goto_8
    move v3, v6

    move v6, v10

    goto :goto_5

    .line 279
    .end local v10    # "i2":I
    .restart local v6    # "i2":I
    :cond_c
    :goto_9
    if-lt v5, v0, :cond_d

    move v7, v5

    move v5, v4

    goto :goto_a

    :cond_d
    add-int/lit8 v7, v5, 0x1

    .end local v5    # "i1":I
    .local v7, "i1":I
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v5

    :goto_a
    move v2, v5

    move v5, v7

    goto :goto_4
.end method

.method public static findEncodingFor(Ljava/io/Writer;)Ljava/lang/String;
    .locals 2
    .param p0, "w"    # Ljava/io/Writer;

    .line 236
    instance-of v0, p0, Ljava/io/OutputStreamWriter;

    if-eqz v0, :cond_0

    .line 237
    move-object v0, p0

    check-cast v0, Ljava/io/OutputStreamWriter;

    invoke-virtual {v0}, Ljava/io/OutputStreamWriter;->getEncoding()Ljava/lang/String;

    move-result-object v0

    .line 238
    .local v0, "enc":Ljava/lang/String;
    invoke-static {v0}, Lcom/fasterxml/aalto/util/CharsetNames;->normalize(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 240
    .end local v0    # "enc":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public static normalize(Ljava/lang/String;)Ljava/lang/String;
    .locals 11
    .param p0, "csName"    # Ljava/lang/String;

    .line 57
    if-eqz p0, :cond_1c

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x3

    if-ge v0, v1, :cond_0

    goto/16 :goto_3

    .line 73
    :cond_0
    const/4 v0, 0x0

    .line 74
    .local v0, "gotCsPrefix":Z
    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 75
    .local v2, "c":C
    const/16 v3, 0x63

    const/4 v4, 0x2

    const/4 v5, 0x1

    if-eq v2, v3, :cond_1

    const/16 v3, 0x43

    if-ne v2, v3, :cond_3

    .line 76
    :cond_1
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v3

    .line 77
    .local v3, "d":C
    const/16 v6, 0x73

    if-eq v3, v6, :cond_2

    const/16 v6, 0x53

    if-ne v3, v6, :cond_3

    .line 78
    :cond_2
    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object p0

    .line 79
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    .line 80
    const/4 v0, 0x1

    .line 84
    .end local v3    # "d":C
    :cond_3
    const-string v1, "UCS-4"

    const-string v3, "UCS-2"

    const-string v6, "Shift_JIS"

    const-string v7, "UTF-32"

    const-string v8, "ISO-8859-1"

    const-string v9, "UTF-16"

    const-string v10, "US-ASCII"

    sparse-switch v2, :sswitch_data_0

    goto/16 :goto_2

    .line 161
    :sswitch_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v6

    if-ge v6, v4, :cond_4

    .line 162
    goto/16 :goto_2

    .line 164
    :cond_4
    invoke-virtual {p0, v5}, Ljava/lang/String;->charAt(I)C

    move-result v4

    sparse-switch v4, :sswitch_data_1

    goto/16 :goto_2

    .line 196
    :sswitch_1
    const-string v1, "UTF-8"

    if-eq p0, v1, :cond_c

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    goto :goto_0

    .line 199
    :cond_5
    const-string v1, "UTF-16BE"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    .line 200
    return-object v1

    .line 202
    :cond_6
    const-string v1, "UTF-16LE"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_7

    .line 203
    return-object v1

    .line 205
    :cond_7
    invoke-static {p0, v9}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 206
    return-object v9

    .line 208
    :cond_8
    const-string v1, "UTF-32BE"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_9

    .line 209
    return-object v1

    .line 211
    :cond_9
    const-string v1, "UTF-32LE"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_a

    .line 212
    return-object v1

    .line 214
    :cond_a
    invoke-static {p0, v7}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    .line 215
    return-object v7

    .line 217
    :cond_b
    const-string v1, "UTF"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 219
    return-object v9

    .line 197
    :cond_c
    :goto_0
    return-object v1

    .line 190
    :sswitch_2
    invoke-static {p0, v10}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 191
    return-object v10

    .line 176
    :sswitch_3
    if-eqz v0, :cond_1b

    .line 177
    const-string v1, "Unicode"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_d

    .line 178
    return-object v9

    .line 180
    :cond_d
    const-string v1, "UnicodeAscii"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_e

    .line 181
    return-object v8

    .line 183
    :cond_e
    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 184
    return-object v10

    .line 167
    :sswitch_4
    invoke-static {p0, v3}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_f

    .line 168
    return-object v9

    .line 170
    :cond_f
    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 171
    return-object v7

    .line 155
    :sswitch_5
    invoke-static {p0, v6}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 156
    return-object v6

    .line 149
    :sswitch_6
    const-string v1, "JIS_Encoding"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 150
    return-object v6

    .line 109
    :sswitch_7
    if-eq p0, v8, :cond_18

    .line 110
    invoke-static {p0, v8}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_18

    .line 111
    const-string v4, "ISO-Latin1"

    invoke-static {p0, v4}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_10

    goto :goto_1

    .line 114
    :cond_10
    const-string v4, "ISO-10646"

    invoke-static {p0, v4}, Lcom/fasterxml/aalto/util/CharsetNames;->encodingStartsWith(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1b

    .line 119
    const-string v4, "10646"

    invoke-virtual {p0, v4}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v4

    .line 120
    .local v4, "ix":I
    add-int/lit8 v5, v4, 0x5

    invoke-virtual {p0, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    .line 121
    .local v5, "suffix":Ljava/lang/String;
    const-string v6, "UCS-Basic"

    invoke-static {v5, v6}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_11

    .line 122
    return-object v10

    .line 124
    :cond_11
    const-string v6, "Unicode-Latin1"

    invoke-static {v5, v6}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_12

    .line 125
    return-object v8

    .line 127
    :cond_12
    invoke-static {v5, v3}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_13

    .line 128
    return-object v9

    .line 130
    :cond_13
    invoke-static {v5, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_14

    .line 131
    return-object v7

    .line 133
    :cond_14
    const-string v1, "UTF-1"

    invoke-static {v5, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_15

    .line 135
    return-object v10

    .line 137
    :cond_15
    const-string v1, "J-1"

    invoke-static {v5, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_16

    .line 140
    return-object v10

    .line 142
    :cond_16
    invoke-static {v5, v10}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_17

    .line 143
    return-object v10

    .line 145
    .end local v4    # "ix":I
    .end local v5    # "suffix":Ljava/lang/String;
    :cond_17
    goto :goto_2

    .line 112
    :cond_18
    :goto_1
    return-object v8

    .line 102
    :sswitch_8
    const-string v1, "EBCDIC"

    invoke-virtual {p0, v1}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_19

    .line 103
    const-string v3, "ebcdic"

    invoke-virtual {p0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1b

    .line 104
    :cond_19
    return-object v1

    .line 95
    :sswitch_9
    const-string v1, "cs"

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->encodingStartsWith(Ljava/lang/String;Ljava/lang/String;)Z

    goto :goto_2

    .line 87
    :sswitch_a
    const-string v1, "ASCII"

    if-eq p0, v1, :cond_1a

    invoke-static {p0, v1}, Lcom/fasterxml/aalto/util/CharsetNames;->equalEncodings(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1b

    .line 88
    :cond_1a
    return-object v10

    .line 225
    :cond_1b
    :goto_2
    return-object p0

    .line 58
    .end local v0    # "gotCsPrefix":Z
    .end local v2    # "c":C
    :cond_1c
    :goto_3
    return-object p0

    nop

    :sswitch_data_0
    .sparse-switch
        0x41 -> :sswitch_a
        0x43 -> :sswitch_9
        0x45 -> :sswitch_8
        0x49 -> :sswitch_7
        0x4a -> :sswitch_6
        0x53 -> :sswitch_5
        0x55 -> :sswitch_0
        0x61 -> :sswitch_a
        0x63 -> :sswitch_9
        0x65 -> :sswitch_8
        0x69 -> :sswitch_7
        0x6a -> :sswitch_6
        0x73 -> :sswitch_5
        0x75 -> :sswitch_0
    .end sparse-switch

    :sswitch_data_1
    .sparse-switch
        0x43 -> :sswitch_4
        0x4e -> :sswitch_3
        0x53 -> :sswitch_2
        0x54 -> :sswitch_1
        0x63 -> :sswitch_4
        0x6e -> :sswitch_3
        0x73 -> :sswitch_2
        0x74 -> :sswitch_1
    .end sparse-switch
.end method
