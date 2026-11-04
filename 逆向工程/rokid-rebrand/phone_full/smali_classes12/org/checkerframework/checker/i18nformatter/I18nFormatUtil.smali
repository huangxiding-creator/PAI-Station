.class public Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil;
.super Ljava/lang/Object;
.source "I18nFormatUtil.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;,
        Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static formatParameterCategories(Ljava/lang/String;)[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    .locals 10
    .param p0, "format"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/util/IllegalFormatException;
        }
    .end annotation

    .line 52
    invoke-static {p0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil;->tryFormatSatisfiability(Ljava/lang/String;)V

    .line 53
    invoke-static {p0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$MessageFormatParser;->parse(Ljava/lang/String;)[Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;

    move-result-object v0

    .line 55
    .local v0, "cs":[Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    const/4 v1, -0x1

    .line 56
    .local v1, "maxIndex":I
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 58
    .local v2, "conv":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Integer;Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;>;"
    array-length v3, v0

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_1

    aget-object v5, v0, v4

    .line 59
    .local v5, "c":Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    iget v6, v5, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;->index:I

    .line 60
    .local v6, "index":I
    invoke-static {v6}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    .line 61
    .local v7, "indexKey":Ljava/lang/Integer;
    iget-object v8, v5, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;->category:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 65
    invoke-interface {v2, v7}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_0

    .line 66
    invoke-interface {v2, v7}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    goto :goto_1

    .line 67
    :cond_0
    sget-object v9, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->UNUSED:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 63
    :goto_1
    invoke-static {v8, v9}, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->intersect(Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;)Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    move-result-object v8

    .line 61
    invoke-interface {v2, v7, v8}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 68
    invoke-static {v1, v6}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 58
    .end local v5    # "c":Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil$I18nConversion;
    .end local v6    # "index":I
    .end local v7    # "indexKey":Ljava/lang/Integer;
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 71
    :cond_1
    add-int/lit8 v3, v1, 0x1

    new-array v3, v3, [Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    .line 72
    .local v3, "res":[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_2
    if-gt v4, v1, :cond_3

    .line 73
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    .line 74
    .local v5, "indexKey":Ljava/lang/Integer;
    nop

    .line 75
    invoke-interface {v2, v5}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v2, v5}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    goto :goto_3

    :cond_2
    sget-object v6, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->UNUSED:Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    :goto_3
    aput-object v6, v3, v4

    .line 72
    .end local v5    # "indexKey":Ljava/lang/Integer;
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 77
    .end local v4    # "i":I
    :cond_3
    return-object v3
.end method

.method public static varargs hasFormat(Ljava/lang/String;[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;)Z
    .locals 5
    .param p0, "format"    # Ljava/lang/String;
    .param p1, "cc"    # [Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    .annotation runtime Lorg/checkerframework/checker/i18nformatter/qual/I18nChecksFormat;
    .end annotation

    .line 91
    invoke-static {p0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil;->formatParameterCategories(Ljava/lang/String;)[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;

    move-result-object v0

    .line 92
    .local v0, "fcc":[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    array-length v1, v0

    array-length v2, p1

    const/4 v3, 0x0

    if-eq v1, v2, :cond_0

    .line 93
    return v3

    .line 96
    :cond_0
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_2

    .line 97
    aget-object v2, p1, v1

    aget-object v4, v0, v1

    invoke-static {v2, v4}, Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;->isSubsetOf(Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;)Z

    move-result v2

    if-nez v2, :cond_1

    .line 98
    return v3

    .line 96
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 101
    .end local v1    # "i":I
    :cond_2
    const/4 v1, 0x1

    return v1
.end method

.method public static isFormat(Ljava/lang/String;)Z
    .locals 2
    .param p0, "format"    # Ljava/lang/String;
    .annotation runtime Lorg/checkerframework/checker/i18nformatter/qual/I18nValidFormat;
    .end annotation

    .line 107
    :try_start_0
    invoke-static {p0}, Lorg/checkerframework/checker/i18nformatter/I18nFormatUtil;->formatParameterCategories(Ljava/lang/String;)[Lorg/checkerframework/checker/i18nformatter/qual/I18nConversionCategory;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 110
    nop

    .line 111
    const/4 v0, 0x1

    return v0

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Ljava/lang/Exception;
    const/4 v1, 0x0

    return v1
.end method

.method public static tryFormatSatisfiability(Ljava/lang/String;)V
    .locals 2
    .param p0, "format"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/util/IllegalFormatException;
        }
    .end annotation

    .line 41
    const/4 v0, 0x0

    move-object v1, v0

    check-cast v1, [Ljava/lang/Object;

    invoke-static {p0, v0}, Ljava/text/MessageFormat;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    .line 42
    return-void
.end method
