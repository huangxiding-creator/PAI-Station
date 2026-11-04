.class Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;
.super Ljava/lang/Object;
.source "I18nFormatUtil.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "MessageFormatParser"
.end annotation


# static fields
.field private static final DATE_TIME_MODIFIER_KEYWORDS:[Ljava/lang/String;

.field private static final MODIFIER_CURRENCY:I = 0x1

.field private static final MODIFIER_DEFAULT:I = 0x0

.field private static final MODIFIER_INTEGER:I = 0x3

.field private static final MODIFIER_PERCENT:I = 0x2

.field private static final NUMBER_MODIFIER_KEYWORDS:[Ljava/lang/String;

.field private static final SEG_INDEX:I = 0x1

.field private static final SEG_MODIFIER:I = 0x3

.field private static final SEG_RAW:I = 0x0

.field private static final SEG_TYPE:I = 0x2

.field private static final TYPE_CHOICE:I = 0x4

.field private static final TYPE_DATE:I = 0x2

.field private static final TYPE_KEYWORDS:[Ljava/lang/String;

.field private static final TYPE_NULL:I = 0x0

.field private static final TYPE_NUMBER:I = 0x1

.field private static final TYPE_TIME:I = 0x3

.field private static argumentIndices:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field private static categories:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;",
            ">;"
        }
    .end annotation
.end field

.field private static locale:Ljava/util/Locale;

.field public static maxOffset:I

.field private static numFormat:I


# direct methods
.method static constructor <clinit>()V
    .locals 9

    .line 165
    const/4 v0, 0x5

    new-array v1, v0, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, ""

    aput-object v3, v1, v2

    const-string v4, "number"

    const/4 v5, 0x1

    aput-object v4, v1, v5

    const-string v4, "date"

    const/4 v6, 0x2

    aput-object v4, v1, v6

    const-string/jumbo v4, "time"

    const/4 v7, 0x3

    aput-object v4, v1, v7

    const-string v4, "choice"

    const/4 v8, 0x4

    aput-object v4, v1, v8

    sput-object v1, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->TYPE_KEYWORDS:[Ljava/lang/String;

    .line 173
    new-array v1, v8, [Ljava/lang/String;

    aput-object v3, v1, v2

    const-string v4, "currency"

    aput-object v4, v1, v5

    const-string v4, "percent"

    aput-object v4, v1, v6

    const-string v4, "integer"

    aput-object v4, v1, v7

    sput-object v1, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->NUMBER_MODIFIER_KEYWORDS:[Ljava/lang/String;

    .line 177
    new-array v0, v0, [Ljava/lang/String;

    aput-object v3, v0, v2

    const-string/jumbo v1, "short"

    aput-object v1, v0, v5

    const-string v1, "medium"

    aput-object v1, v0, v6

    const-string v1, "long"

    aput-object v1, v0, v7

    const-string v1, "full"

    aput-object v1, v0, v8

    sput-object v0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->DATE_TIME_MODIFIER_KEYWORDS:[Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 129
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static applyPattern(Ljava/lang/String;)V
    .locals 12
    .param p0, "pattern"    # Ljava/lang/String;
    .annotation runtime Lorg/checkerframework/checker/nullness/qual/RequiresNonNull;
        value = {
            "argumentIndices",
            "categories",
            "locale"
        }
    .end annotation

    .line 198
    const/4 v0, 0x4

    new-array v0, v0, [Ljava/lang/StringBuilder;

    .line 201
    .local v0, "segments":[Ljava/lang/StringBuilder;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x0

    aput-object v1, v0, v2

    .line 203
    const/4 v1, 0x0

    .line 204
    .local v1, "part":I
    sput v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    .line 205
    const/4 v3, 0x0

    .line 206
    .local v3, "inQuote":Z
    const/4 v4, 0x0

    .line 207
    .local v4, "braceStack":I
    const/4 v5, -0x1

    sput v5, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 208
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v7

    if-ge v6, v7, :cond_a

    .line 209
    invoke-virtual {p0, v6}, Ljava/lang/String;->charAt(I)C

    move-result v7

    .line 210
    .local v7, "ch":C
    const/16 v8, 0x27

    const/4 v9, 0x1

    if-nez v1, :cond_4

    .line 211
    if-ne v7, v8, :cond_2

    .line 212
    add-int/lit8 v10, v6, 0x1

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v11

    if-ge v10, v11, :cond_0

    add-int/lit8 v10, v6, 0x1

    invoke-virtual {p0, v10}, Ljava/lang/String;->charAt(I)C

    move-result v10

    if-ne v10, v8, :cond_0

    .line 213
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 214
    add-int/lit8 v6, v6, 0x1

    goto/16 :goto_2

    .line 216
    :cond_0
    if-nez v3, :cond_1

    move v8, v9

    goto :goto_1

    :cond_1
    move v8, v2

    :goto_1
    move v3, v8

    goto/16 :goto_2

    .line 218
    :cond_2
    const/16 v8, 0x7b

    if-ne v7, v8, :cond_3

    if-nez v3, :cond_3

    .line 219
    const/4 v1, 0x1

    .line 220
    aget-object v8, v0, v9

    if-nez v8, :cond_9

    .line 221
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    aput-object v8, v0, v9

    goto/16 :goto_2

    .line 224
    :cond_3
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto/16 :goto_2

    .line 227
    :cond_4
    if-eqz v3, :cond_5

    .line 228
    aget-object v10, v0, v1

    invoke-virtual {v10, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 229
    if-ne v7, v8, :cond_9

    .line 230
    const/4 v3, 0x0

    goto :goto_2

    .line 233
    :cond_5
    const/4 v8, 0x3

    const/4 v10, 0x2

    sparse-switch v7, :sswitch_data_0

    .line 272
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto :goto_2

    .line 248
    :sswitch_0
    if-nez v4, :cond_6

    .line 249
    const/4 v1, 0x0

    .line 250
    sget v11, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    invoke-static {v11, v0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->makeFormat(I[Ljava/lang/StringBuilder;)V

    .line 251
    sget v11, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    add-int/2addr v11, v9

    sput v11, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    .line 253
    const/4 v11, 0x0

    aput-object v11, v0, v9

    .line 254
    aput-object v11, v0, v10

    .line 255
    aput-object v11, v0, v8

    goto :goto_2

    .line 257
    :cond_6
    add-int/lit8 v4, v4, -0x1

    .line 258
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 260
    goto :goto_2

    .line 244
    :sswitch_1
    add-int/lit8 v4, v4, 0x1

    .line 245
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 246
    goto :goto_2

    .line 235
    :sswitch_2
    if-ge v1, v8, :cond_7

    .line 236
    add-int/lit8 v1, v1, 0x1

    aget-object v8, v0, v1

    if-nez v8, :cond_9

    .line 237
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    aput-object v8, v0, v1

    goto :goto_2

    .line 240
    :cond_7
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 242
    goto :goto_2

    .line 268
    :sswitch_3
    const/4 v3, 0x1

    .line 269
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 270
    goto :goto_2

    .line 263
    :sswitch_4
    if-ne v1, v10, :cond_8

    aget-object v8, v0, v10

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->length()I

    move-result v8

    if-lez v8, :cond_9

    .line 264
    :cond_8
    aget-object v8, v0, v1

    invoke-virtual {v8, v7}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 208
    .end local v7    # "ch":C
    :cond_9
    :goto_2
    add-int/2addr v6, v9

    goto/16 :goto_0

    .line 278
    .end local v6    # "i":I
    :cond_a
    if-nez v4, :cond_c

    if-nez v1, :cond_b

    goto :goto_3

    .line 279
    :cond_b
    sput v5, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 280
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v5, "Unmatched braces in the pattern"

    invoke-direct {v2, v5}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 282
    :cond_c
    :goto_3
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x20 -> :sswitch_4
        0x27 -> :sswitch_3
        0x2c -> :sswitch_2
        0x7b -> :sswitch_1
        0x7d -> :sswitch_0
    .end sparse-switch
.end method

.method private static final findKeyword(Ljava/lang/String;[Ljava/lang/String;)I
    .locals 3
    .param p0, "s"    # Ljava/lang/String;
    .param p1, "list"    # [Ljava/lang/String;

    .line 389
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 390
    aget-object v1, p1, v0

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 391
    return v0

    .line 389
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 397
    .end local v0    # "i":I
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 398
    .local v0, "ls":Ljava/lang/String;
    if-eq v0, p0, :cond_3

    .line 399
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1
    array-length v2, p1

    if-ge v1, v2, :cond_3

    .line 400
    aget-object v2, p1, v1

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 401
    return v1

    .line 399
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 405
    .end local v1    # "i":I
    :cond_3
    const/4 v1, -0x1

    return v1
.end method

.method private static makeFormat(I[Ljava/lang/StringBuilder;)V
    .locals 10
    .param p0, "offsetNumber"    # I
    .param p1, "textSegments"    # [Ljava/lang/StringBuilder;
    .annotation runtime Lorg/checkerframework/checker/nullness/qual/RequiresNonNull;
        value = {
            "argumentIndices",
            "categories",
            "locale"
        }
    .end annotation

    .line 287
    array-length v0, p1

    new-array v0, v0, [Ljava/lang/String;

    .line 288
    .local v0, "segments":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    .line 289
    aget-object v2, p1, v1

    .line 290
    .local v2, "oneseg":Ljava/lang/StringBuilder;
    if-eqz v2, :cond_0

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    :cond_0
    const-string v3, ""

    :goto_1
    aput-object v3, v0, v1

    .line 288
    .end local v2    # "oneseg":Ljava/lang/StringBuilder;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 296
    .end local v1    # "i":I
    :cond_1
    const/4 v1, 0x1

    :try_start_0
    aget-object v2, v0, v1

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_3

    .line 301
    .local v1, "argumentNumber":I
    nop

    .line 302
    if-ltz v1, :cond_5

    .line 306
    sget v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 307
    .local v2, "oldMaxOffset":I
    sput p0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 308
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->argumentIndices:Ljava/util/List;

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {v3, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 311
    const/4 v3, 0x0

    .line 312
    .local v3, "category":Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    const/4 v4, 0x2

    aget-object v5, v0, v4

    invoke-virtual {v5}, Ljava/lang/String;->length()I

    move-result v5

    if-eqz v5, :cond_4

    .line 313
    aget-object v5, v0, v4

    sget-object v6, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->TYPE_KEYWORDS:[Ljava/lang/String;

    invoke-static {v5, v6}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->findKeyword(Ljava/lang/String;[Ljava/lang/String;)I

    move-result v5

    .line 314
    .local v5, "type":I
    const/4 v6, 0x3

    packed-switch v5, :pswitch_data_0

    .line 374
    sput v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 375
    new-instance v6, Ljava/lang/IllegalArgumentException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "unknown format type: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    aget-object v4, v0, v4

    invoke-virtual {v7, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v6, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 357
    :pswitch_0
    aget-object v4, v0, v6

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-eqz v4, :cond_2

    .line 364
    :try_start_1
    new-instance v4, Ljava/text/ChoiceFormat;

    aget-object v7, v0, v6

    invoke-direct {v4, v7}, Ljava/text/ChoiceFormat;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 370
    nop

    .line 371
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->NUMBER:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 372
    goto/16 :goto_5

    .line 365
    :catch_0
    move-exception v4

    .line 366
    .local v4, "e":Ljava/lang/Exception;
    sput v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 368
    new-instance v7, Ljava/lang/IllegalArgumentException;

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "Choice Pattern incorrect: "

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    aget-object v6, v0, v6

    invoke-virtual {v8, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v7, v6, v4}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v7

    .line 358
    .end local v4    # "e":Ljava/lang/Exception;
    :cond_2
    new-instance v4, Ljava/lang/IllegalArgumentException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Choice Pattern requires Subformat Pattern: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    aget-object v6, v0, v6

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v4, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 341
    :pswitch_1
    aget-object v4, v0, v6

    sget-object v7, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->DATE_TIME_MODIFIER_KEYWORDS:[Ljava/lang/String;

    invoke-static {v4, v7}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->findKeyword(Ljava/lang/String;[Ljava/lang/String;)I

    move-result v4

    .line 342
    .local v4, "mod":I
    if-ltz v4, :cond_3

    sget-object v7, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->DATE_TIME_MODIFIER_KEYWORDS:[Ljava/lang/String;

    array-length v7, v7

    if-ge v4, v7, :cond_3

    goto :goto_2

    .line 347
    :cond_3
    :try_start_2
    new-instance v7, Ljava/text/SimpleDateFormat;

    aget-object v6, v0, v6

    sget-object v8, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->locale:Ljava/util/Locale;

    invoke-direct {v7, v6, v8}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V
    :try_end_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_2 .. :try_end_2} :catch_1

    .line 352
    nop

    .line 354
    :goto_2
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->DATE:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 355
    goto :goto_5

    .line 348
    :catch_1
    move-exception v6

    .line 349
    .local v6, "e":Ljava/lang/IllegalArgumentException;
    sput v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 351
    throw v6

    .line 319
    .end local v4    # "mod":I
    .end local v6    # "e":Ljava/lang/IllegalArgumentException;
    :pswitch_2
    aget-object v4, v0, v6

    sget-object v7, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->NUMBER_MODIFIER_KEYWORDS:[Ljava/lang/String;

    invoke-static {v4, v7}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->findKeyword(Ljava/lang/String;[Ljava/lang/String;)I

    move-result v4

    packed-switch v4, :pswitch_data_1

    .line 327
    :try_start_3
    new-instance v4, Ljava/text/DecimalFormat;

    goto :goto_3

    .line 324
    :pswitch_3
    goto :goto_4

    .line 327
    :goto_3
    aget-object v6, v0, v6

    sget-object v7, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->locale:Ljava/util/Locale;

    .line 329
    invoke-static {v7}, Ljava/text/DecimalFormatSymbols;->getInstance(Ljava/util/Locale;)Ljava/text/DecimalFormatSymbols;

    move-result-object v7

    invoke-direct {v4, v6, v7}, Ljava/text/DecimalFormat;-><init>(Ljava/lang/String;Ljava/text/DecimalFormatSymbols;)V
    :try_end_3
    .catch Ljava/lang/IllegalArgumentException; {:try_start_3 .. :try_end_3} :catch_2

    .line 334
    nop

    .line 337
    :goto_4
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->NUMBER:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 338
    goto :goto_5

    .line 330
    :catch_2
    move-exception v4

    .line 331
    .local v4, "e":Ljava/lang/IllegalArgumentException;
    sput v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->maxOffset:I

    .line 333
    throw v4

    .line 316
    .end local v4    # "e":Ljava/lang/IllegalArgumentException;
    :pswitch_4
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->GENERAL:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 317
    nop

    .line 378
    .end local v5    # "type":I
    :goto_5
    goto :goto_6

    .line 379
    :cond_4
    sget-object v3, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->GENERAL:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 381
    :goto_6
    sget-object v4, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->categories:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 382
    return-void

    .line 303
    .end local v2    # "oldMaxOffset":I
    .end local v3    # "category":Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    :cond_5
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "negative argument number: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 298
    .end local v1    # "argumentNumber":I
    :catch_3
    move-exception v2

    .line 299
    .local v2, "e":Ljava/lang/NumberFormatException;
    new-instance v3, Ljava/lang/IllegalArgumentException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "can\'t parse argument number: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v1, v0, v1

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v3, v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v3

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x0
        :pswitch_3
        :pswitch_3
        :pswitch_3
        :pswitch_3
    .end packed-switch
.end method

.method public static parse(Ljava/lang/String;)[Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    .locals 5
    .param p0, "pattern"    # Ljava/lang/String;
    .annotation runtime Lorg/checkerframework/checker/nullness/qual/EnsuresNonNull;
        value = {
            "categories",
            "argumentIndices",
            "locale"
        }
    .end annotation

    .line 183
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->categories:Ljava/util/List;

    .line 184
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->argumentIndices:Ljava/util/List;

    .line 185
    sget-object v0, Ljava/util/Locale$Category;->FORMAT:Ljava/util/Locale$Category;

    invoke-static {v0}, Ljava/util/Locale;->getDefault(Ljava/util/Locale$Category;)Ljava/util/Locale;

    move-result-object v0

    sput-object v0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->locale:Ljava/util/Locale;

    .line 186
    invoke-static {p0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->applyPattern(Ljava/lang/String;)V

    .line 188
    sget v0, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    new-array v0, v0, [Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;

    .line 189
    .local v0, "ret":[Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    sget v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->numFormat:I

    if-ge v1, v2, :cond_0

    .line 190
    new-instance v2, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;

    sget-object v3, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->argumentIndices:Ljava/util/List;

    invoke-interface {v3, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    sget-object v4, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->categories:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    invoke-direct {v2, v3, v4}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;-><init>(ILorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;)V

    aput-object v2, v0, v1

    .line 189
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 192
    .end local v1    # "i":I
    :cond_0
    return-object v0
.end method
