.class public Lorg/checkerframework/checker/formatter/FormatUtil;
.super Ljava/lang/Object;
.source "FormatUtil.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/checkerframework/checker/formatter/FormatUtil$IllegalFormatConversionCategoryException;,
        Lorg/checkerframework/checker/formatter/FormatUtil$ExcessiveOrMissingFormatArgumentException;,
        Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;
    }
.end annotation


# static fields
.field static final synthetic $assertionsDisabled:Z = false

.field private static final formatSpecifier:Ljava/lang/String; = "%(\\d+\\$)?([-#+ 0,(\\<]*)?(\\d+)?(\\.\\d+)?([tT])?([a-zA-Z%])"

.field private static final formatSpecifierConversion:I = 0x6

.field private static final formatSpecifierT:I = 0x5

.field private static fsPattern:Ljava/util/regex/Pattern;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 17
    nop

    .line 179
    const-string v0, "%(\\d+\\$)?([-#+ 0,(\\<]*)?(\\d+)?(\\.\\d+)?([tT])?([a-zA-Z%])"

    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lorg/checkerframework/checker/formatter/FormatUtil;->fsPattern:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static varargs asFormat(Ljava/lang/String;[Lorg/checkerframework/checker/formatter/qual/ConversionCategory;)Ljava/lang/String;
    .locals 5
    .param p0, "format"    # Ljava/lang/String;
    .param p1, "cc"    # [Lorg/checkerframework/checker/formatter/qual/ConversionCategory;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/util/IllegalFormatException;
        }
    .end annotation

    .annotation runtime Lorg/checkerframework/checker/formatter/qual/ReturnsFormat;
    .end annotation

    .line 74
    invoke-static {p0}, Lorg/checkerframework/checker/formatter/FormatUtil;->formatParameterCategories(Ljava/lang/String;)[Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    move-result-object v0

    .line 75
    .local v0, "fcc":[Lorg/checkerframework/checker/formatter/qual/ConversionCategory;
    array-length v1, v0

    array-length v2, p1

    if-ne v1, v2, :cond_2

    .line 79
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_1

    .line 80
    aget-object v2, p1, v1

    aget-object v3, v0, v1

    if-ne v2, v3, :cond_0

    .line 79
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 81
    :cond_0
    new-instance v2, Lorg/checkerframework/checker/formatter/FormatUtil$IllegalFormatConversionCategoryException;

    aget-object v3, p1, v1

    aget-object v4, v0, v1

    invoke-direct {v2, v3, v4}, Lorg/checkerframework/checker/formatter/FormatUtil$IllegalFormatConversionCategoryException;-><init>(Lorg/checkerframework/checker/formatter/qual/ConversionCategory;Lorg/checkerframework/checker/formatter/qual/ConversionCategory;)V

    throw v2

    .line 85
    .end local v1    # "i":I
    :cond_1
    return-object p0

    .line 76
    :cond_2
    new-instance v1, Lorg/checkerframework/checker/formatter/FormatUtil$ExcessiveOrMissingFormatArgumentException;

    array-length v2, p1

    array-length v3, v0

    invoke-direct {v1, v2, v3}, Lorg/checkerframework/checker/formatter/FormatUtil$ExcessiveOrMissingFormatArgumentException;-><init>(II)V

    throw v1
.end method

.method public static conversionCharFromFormat(Ljava/lang/String;)C
    .locals 2
    .param p0, "formatSpecifier"    # Ljava/lang/String;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 233
    sget-object v0, Lorg/checkerframework/checker/formatter/FormatUtil;->fsPattern:Ljava/util/regex/Pattern;

    invoke-virtual {v0, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v0

    .line 234
    .local v0, "m":Ljava/util/regex/Matcher;
    invoke-virtual {v0}, Ljava/util/regex/Matcher;->find()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 235
    invoke-static {v0}, Lorg/checkerframework/checker/formatter/FormatUtil;->conversionCharFromFormat(Ljava/util/regex/Matcher;)C

    move-result v1

    return v1

    .line 234
    :cond_0
    new-instance v1, Ljava/lang/AssertionError;

    invoke-direct {v1}, Ljava/lang/AssertionError;-><init>()V

    throw v1
.end method

.method private static conversionCharFromFormat(Ljava/util/regex/Matcher;)C
    .locals 3
    .param p0, "m"    # Ljava/util/regex/Matcher;

    .line 213
    const/4 v0, 0x5

    invoke-virtual {p0, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    .line 214
    .local v0, "tGroup":Ljava/lang/String;
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 215
    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    return v1

    .line 217
    :cond_0
    const/4 v2, 0x6

    invoke-virtual {p0, v2}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v1

    return v1
.end method

.method public static formatParameterCategories(Ljava/lang/String;)[Lorg/checkerframework/checker/formatter/qual/ConversionCategory;
    .locals 13
    .param p0, "format"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/util/IllegalFormatException;
        }
    .end annotation

    .line 110
    invoke-static {p0}, Lorg/checkerframework/checker/formatter/FormatUtil;->tryFormatSatisfiability(Ljava/lang/String;)V

    .line 112
    const/4 v0, -0x1

    .line 113
    .local v0, "last":I
    const/4 v1, -0x1

    .line 114
    .local v1, "lasto":I
    const/4 v2, -0x1

    .line 116
    .local v2, "maxindex":I
    invoke-static {p0}, Lorg/checkerframework/checker/formatter/FormatUtil;->parse(Ljava/lang/String;)[Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;

    move-result-object v3

    .line 117
    .local v3, "cs":[Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;
    new-instance v4, Ljava/util/HashMap;

    invoke-direct {v4}, Ljava/util/HashMap;-><init>()V

    .line 119
    .local v4, "conv":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/checkerframework/checker/formatter/qual/ConversionCategory;>;"
    array-length v5, v3

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v5, :cond_1

    aget-object v7, v3, v6

    .line 120
    .local v7, "c":Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;
    invoke-virtual {v7}, Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;->index()I

    move-result v8

    .line 121
    .local v8, "index":I
    packed-switch v8, :pswitch_data_0

    .line 129
    add-int/lit8 v0, v8, -0x1

    goto :goto_1

    .line 125
    :pswitch_0
    add-int/lit8 v1, v1, 0x1

    .line 126
    move v0, v1

    .line 127
    goto :goto_1

    .line 123
    :pswitch_1
    nop

    .line 132
    :goto_1
    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v2

    .line 133
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v9

    .line 134
    .local v9, "lastKey":Ljava/lang/Integer;
    nop

    .line 135
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v10

    .line 137
    invoke-interface {v4, v9}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v11

    if-eqz v11, :cond_0

    .line 138
    invoke-interface {v4, v9}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    goto :goto_2

    .line 139
    :cond_0
    sget-object v11, Lorg/checkerframework/checker/formatter/qual/ConversionCategory;->UNUSED:Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    .line 140
    :goto_2
    invoke-virtual {v7}, Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;->category()Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    move-result-object v12

    .line 136
    invoke-static {v11, v12}, Lorg/checkerframework/checker/formatter/qual/ConversionCategory;->intersect(Lorg/checkerframework/checker/formatter/qual/ConversionCategory;Lorg/checkerframework/checker/formatter/qual/ConversionCategory;)Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    move-result-object v11

    .line 134
    invoke-interface {v4, v10, v11}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 119
    .end local v7    # "c":Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;
    .end local v8    # "index":I
    .end local v9    # "lastKey":Ljava/lang/Integer;
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 143
    :cond_1
    add-int/lit8 v5, v2, 0x1

    new-array v5, v5, [Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    .line 144
    .local v5, "res":[Lorg/checkerframework/checker/formatter/qual/ConversionCategory;
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_3
    if-gt v6, v2, :cond_3

    .line 145
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 146
    .local v7, "key":Ljava/lang/Integer;
    invoke-interface {v4, v7}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_2

    invoke-interface {v4, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    goto :goto_4

    :cond_2
    sget-object v8, Lorg/checkerframework/checker/formatter/qual/ConversionCategory;->UNUSED:Lorg/checkerframework/checker/formatter/qual/ConversionCategory;

    :goto_4
    aput-object v8, v5, v6

    .line 144
    .end local v7    # "key":Ljava/lang/Integer;
    add-int/lit8 v6, v6, 0x1

    goto :goto_3

    .line 148
    .end local v6    # "i":I
    :cond_3
    return-object v5

    :pswitch_data_0
    .packed-switch -0x1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static indexFromFormat(Ljava/util/regex/Matcher;)I
    .locals 3
    .param p0, "m"    # Ljava/util/regex/Matcher;

    .line 190
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v1

    .line 191
    .local v1, "s":Ljava/lang/String;
    if-eqz v1, :cond_0

    .line 192
    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, v0

    const/4 v0, 0x0

    invoke-virtual {v1, v0, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .local v0, "index":I
    goto :goto_0

    .line 194
    .end local v0    # "index":I
    :cond_0
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Ljava/util/regex/Matcher;->group(I)Ljava/lang/String;

    move-result-object v0

    .line 195
    .local v0, "group2":Ljava/lang/String;
    if-eqz v0, :cond_1

    const/16 v2, 0x3c

    invoke-static {v2}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 196
    const/4 v2, -0x1

    move v0, v2

    .local v2, "index":I
    goto :goto_0

    .line 198
    .end local v2    # "index":I
    :cond_1
    const/4 v2, 0x0

    move v0, v2

    .line 201
    .local v0, "index":I
    :goto_0
    return v0
.end method

.method private static parse(Ljava/lang/String;)[Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;
    .locals 5
    .param p0, "format"    # Ljava/lang/String;

    .line 245
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 246
    .local v0, "cs":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;>;"
    sget-object v1, Lorg/checkerframework/checker/formatter/FormatUtil;->fsPattern:Ljava/util/regex/Pattern;

    invoke-virtual {v1, p0}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object v1

    .line 247
    .local v1, "m":Ljava/util/regex/Matcher;
    :goto_0
    invoke-virtual {v1}, Ljava/util/regex/Matcher;->find()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 248
    invoke-static {v1}, Lorg/checkerframework/checker/formatter/FormatUtil;->conversionCharFromFormat(Ljava/util/regex/Matcher;)C

    move-result v2

    .line 249
    .local v2, "c":C
    sparse-switch v2, :sswitch_data_0

    .line 254
    new-instance v3, Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;

    invoke-static {v1}, Lorg/checkerframework/checker/formatter/FormatUtil;->indexFromFormat(Ljava/util/regex/Matcher;)I

    move-result v4

    invoke-direct {v3, v2, v4}, Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;-><init>(CI)V

    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 252
    :sswitch_0
    nop

    .line 256
    .end local v2    # "c":C
    :goto_1
    goto :goto_0

    .line 257
    :cond_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Lorg/checkerframework/checker/formatter/FormatUtil$Conversion;

    return-object v2

    :sswitch_data_0
    .sparse-switch
        0x25 -> :sswitch_0
        0x6e -> :sswitch_0
    .end sparse-switch
.end method

.method public static tryFormatSatisfiability(Ljava/lang/String;)V
    .locals 2
    .param p0, "format"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/util/IllegalFormatException;
        }
    .end annotation

    .line 100
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, [Ljava/lang/Object;

    invoke-static {p0, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 101
    .local v0, "unused":Ljava/lang/String;
    return-void
.end method
