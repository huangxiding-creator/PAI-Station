.class public Lorg/apache/log4j/helpers/PatternParser;
.super Ljava/lang/Object;
.source "PatternParser.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/log4j/helpers/PatternParser$CategoryPatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$ClassNamePatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$NamedPatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$MDCPatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$DatePatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;,
        Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;
    }
.end annotation


# static fields
.field static final CLASS_LOCATION_CONVERTER:I = 0x3ea

.field private static final CONVERTER_STATE:I = 0x1

.field private static final DOT_STATE:I = 0x3

.field private static final ESCAPE_CHAR:C = '%'

.field static final FILE_LOCATION_CONVERTER:I = 0x3ec

.field static final FULL_LOCATION_CONVERTER:I = 0x3e8

.field static final LEVEL_CONVERTER:I = 0x7d2

.field static final LINE_LOCATION_CONVERTER:I = 0x3eb

.field private static final LITERAL_STATE:I = 0x0

.field private static final MAX_STATE:I = 0x5

.field static final MESSAGE_CONVERTER:I = 0x7d4

.field static final METHOD_LOCATION_CONVERTER:I = 0x3e9

.field private static final MIN_STATE:I = 0x4

.field static final NDC_CONVERTER:I = 0x7d3

.field static final RELATIVE_TIME_CONVERTER:I = 0x7d0

.field static final THREAD_CONVERTER:I = 0x7d1

.field static synthetic class$java$text$DateFormat:Ljava/lang/Class;


# instance fields
.field protected currentLiteral:Ljava/lang/StringBuffer;

.field protected formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

.field head:Lorg/apache/log4j/helpers/PatternConverter;

.field protected i:I

.field protected pattern:Ljava/lang/String;

.field protected patternLength:I

.field state:I

.field tail:Lorg/apache/log4j/helpers/PatternConverter;


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 2
    .param p1, "pattern"    # Ljava/lang/String;

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    new-instance v0, Ljava/lang/StringBuffer;

    const/16 v1, 0x20

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    iput-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    .line 73
    new-instance v0, Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-direct {v0}, Lorg/apache/log4j/helpers/FormattingInfo;-><init>()V

    iput-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    .line 78
    iput-object p1, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    .line 79
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    iput v0, p0, Lorg/apache/log4j/helpers/PatternParser;->patternLength:I

    .line 80
    const/4 v0, 0x0

    iput v0, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    .line 81
    return-void
.end method

.method private addToList(Lorg/apache/log4j/helpers/PatternConverter;)V
    .locals 1
    .param p1, "pc"    # Lorg/apache/log4j/helpers/PatternConverter;

    .line 85
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->head:Lorg/apache/log4j/helpers/PatternConverter;

    if-nez v0, :cond_0

    .line 86
    iput-object p1, p0, Lorg/apache/log4j/helpers/PatternParser;->tail:Lorg/apache/log4j/helpers/PatternConverter;

    iput-object p1, p0, Lorg/apache/log4j/helpers/PatternParser;->head:Lorg/apache/log4j/helpers/PatternConverter;

    goto :goto_0

    .line 88
    :cond_0
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->tail:Lorg/apache/log4j/helpers/PatternConverter;

    iput-object p1, v0, Lorg/apache/log4j/helpers/PatternConverter;->next:Lorg/apache/log4j/helpers/PatternConverter;

    .line 89
    iput-object p1, p0, Lorg/apache/log4j/helpers/PatternParser;->tail:Lorg/apache/log4j/helpers/PatternConverter;

    .line 91
    :goto_0
    return-void
.end method

.method static synthetic class$(Ljava/lang/String;)Ljava/lang/Class;
    .locals 2
    .param p0, "x0"    # Ljava/lang/String;

    .line 272
    :try_start_0
    invoke-static {p0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .local v0, "x1":Ljava/lang/ClassNotFoundException;
    new-instance v1, Ljava/lang/NoClassDefFoundError;

    invoke-direct {v1}, Ljava/lang/NoClassDefFoundError;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/NoClassDefFoundError;->initCause(Ljava/lang/Throwable;)Ljava/lang/Throwable;

    move-result-object v1

    throw v1
.end method


# virtual methods
.method protected addConverter(Lorg/apache/log4j/helpers/PatternConverter;)V
    .locals 2
    .param p1, "pc"    # Lorg/apache/log4j/helpers/PatternConverter;

    .line 369
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 371
    invoke-direct {p0, p1}, Lorg/apache/log4j/helpers/PatternParser;->addToList(Lorg/apache/log4j/helpers/PatternConverter;)V

    .line 373
    iput v1, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    .line 375
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-virtual {v0}, Lorg/apache/log4j/helpers/FormattingInfo;->reset()V

    .line 376
    return-void
.end method

.method protected extractOption()Ljava/lang/String;
    .locals 3

    .line 95
    iget v0, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    iget v1, p0, Lorg/apache/log4j/helpers/PatternParser;->patternLength:I

    if-ge v0, v1, :cond_0

    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    iget v1, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x7b

    if-ne v0, v1, :cond_0

    .line 96
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    const/16 v1, 0x7d

    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->indexOf(II)I

    move-result v0

    .line 97
    .local v0, "end":I
    iget v1, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    if-le v0, v1, :cond_0

    .line 98
    iget-object v1, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    add-int/lit8 v2, v2, 0x1

    invoke-virtual {v1, v2, v0}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 99
    .local v1, "r":Ljava/lang/String;
    add-int/lit8 v2, v0, 0x1

    iput v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    .line 100
    return-object v1

    .line 103
    .end local v0    # "end":I
    .end local v1    # "r":Ljava/lang/String;
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method protected extractPrecisionOption()I
    .locals 5

    .line 112
    invoke-virtual {p0}, Lorg/apache/log4j/helpers/PatternParser;->extractOption()Ljava/lang/String;

    move-result-object v0

    .line 113
    .local v0, "opt":Ljava/lang/String;
    const/4 v1, 0x0

    .line 114
    .local v1, "r":I
    if-eqz v0, :cond_1

    .line 116
    :try_start_0
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    move v1, v2

    .line 117
    if-gtz v1, :cond_0

    .line 118
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Precision option ("

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ") isn\'t a positive integer."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    .line 120
    const/4 v1, 0x0

    .line 125
    :cond_0
    goto :goto_0

    .line 123
    :catch_0
    move-exception v2

    .line 124
    .local v2, "e":Ljava/lang/NumberFormatException;
    new-instance v3, Ljava/lang/StringBuffer;

    invoke-direct {v3}, Ljava/lang/StringBuffer;-><init>()V

    const-string v4, "Category option \""

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    const-string v4, "\" not a decimal integer."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, v2}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 127
    .end local v2    # "e":Ljava/lang/NumberFormatException;
    :cond_1
    :goto_0
    return v1
.end method

.method protected finalizeConverter(C)V
    .locals 9
    .param p1, "c"    # C

    .line 231
    const/4 v0, 0x0

    .line 232
    .local v0, "pc":Lorg/apache/log4j/helpers/PatternConverter;
    const/4 v1, 0x0

    const/4 v2, 0x0

    sparse-switch p1, :sswitch_data_0

    move-object v3, v2

    .local v3, "xOpt":Ljava/lang/String;
    move-object v4, v2

    .local v4, "df":Ljava/text/DateFormat;
    move-object v5, v2

    .line 358
    .local v2, "dOpt":Ljava/lang/String;
    .local v5, "dateFormatStr":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    const-string v7, "Unexpected char ["

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    invoke-virtual {v6, p1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v6

    const-string v7, "] at position "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    iget v7, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v6

    const-string v7, " in conversion patterrn."

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;)V

    .line 360
    new-instance v6, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;

    iget-object v7, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v7}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;-><init>(Ljava/lang/String;)V

    move-object v0, v6

    .line 361
    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "xOpt":Ljava/lang/String;
    .end local v4    # "df":Ljava/text/DateFormat;
    .end local v5    # "dateFormatStr":Ljava/lang/String;
    :sswitch_0
    move-object v3, v2

    .local v3, "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 348
    .restart local v2    # "dOpt":Ljava/lang/String;
    .local v4, "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x7d3

    invoke-direct {v5, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 350
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 351
    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_1
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 328
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x7d1

    invoke-direct {v5, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 331
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 332
    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_2
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 321
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x7d0

    invoke-direct {v5, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 325
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 326
    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_3
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 315
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x7d2

    invoke-direct {v5, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 318
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 319
    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_4
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 302
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x7d4

    invoke-direct {v5, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$BasicPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 305
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 306
    goto/16 :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_5
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 288
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x3e8

    invoke-direct {v5, p0, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 292
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 293
    goto/16 :goto_2

    .line 248
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_6
    const-string v3, "ISO8601"

    .line 250
    .local v3, "dateFormatStr":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/apache/log4j/helpers/PatternParser;->extractOption()Ljava/lang/String;

    move-result-object v4

    .line 251
    .local v4, "dOpt":Ljava/lang/String;
    if-eqz v4, :cond_0

    .line 252
    move-object v3, v4

    .line 254
    :cond_0
    const-string v5, "ISO8601"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 256
    new-instance v2, Lorg/apache/log4j/helpers/ISO8601DateFormat;

    invoke-direct {v2}, Lorg/apache/log4j/helpers/ISO8601DateFormat;-><init>()V

    .local v2, "df":Ljava/text/DateFormat;
    goto :goto_1

    .line 257
    .end local v2    # "df":Ljava/text/DateFormat;
    :cond_1
    const-string v5, "ABSOLUTE"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 259
    new-instance v2, Lorg/apache/log4j/helpers/AbsoluteTimeDateFormat;

    invoke-direct {v2}, Lorg/apache/log4j/helpers/AbsoluteTimeDateFormat;-><init>()V

    .restart local v2    # "df":Ljava/text/DateFormat;
    goto :goto_1

    .line 260
    .end local v2    # "df":Ljava/text/DateFormat;
    :cond_2
    const-string v5, "DATE"

    invoke-virtual {v3, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 262
    new-instance v2, Lorg/apache/log4j/helpers/DateTimeDateFormat;

    invoke-direct {v2}, Lorg/apache/log4j/helpers/DateTimeDateFormat;-><init>()V

    .restart local v2    # "df":Ljava/text/DateFormat;
    goto :goto_1

    .line 265
    .end local v2    # "df":Ljava/text/DateFormat;
    :cond_3
    :try_start_0
    new-instance v5, Ljava/text/SimpleDateFormat;

    invoke-direct {v5, v3}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v5

    .line 273
    .restart local v2    # "df":Ljava/text/DateFormat;
    goto :goto_1

    .line 267
    .end local v2    # "df":Ljava/text/DateFormat;
    :catch_0
    move-exception v5

    .line 268
    .restart local v2    # "df":Ljava/text/DateFormat;
    .local v5, "e":Ljava/lang/IllegalArgumentException;
    new-instance v6, Ljava/lang/StringBuffer;

    invoke-direct {v6}, Ljava/lang/StringBuffer;-><init>()V

    const-string v7, "Could not instantiate SimpleDateFormat with "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    invoke-virtual {v6, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6, v5}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 270
    sget-object v6, Lorg/apache/log4j/helpers/PatternParser;->class$java$text$DateFormat:Ljava/lang/Class;

    if-nez v6, :cond_4

    const-string v6, "java.text.DateFormat"

    invoke-static {v6}, Lorg/apache/log4j/helpers/PatternParser;->class$(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v6

    sput-object v6, Lorg/apache/log4j/helpers/PatternParser;->class$java$text$DateFormat:Ljava/lang/Class;

    goto :goto_0

    :cond_4
    sget-object v6, Lorg/apache/log4j/helpers/PatternParser;->class$java$text$DateFormat:Ljava/lang/Class;

    :goto_0
    const/4 v7, 0x0

    const-string v8, "org.apache.log4j.helpers.ISO8601DateFormat"

    invoke-static {v8, v6, v7}, Lorg/apache/log4j/helpers/OptionConverter;->instantiateByClassName(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    move-object v2, v6

    check-cast v2, Ljava/text/DateFormat;

    .line 275
    .end local v5    # "e":Ljava/lang/IllegalArgumentException;
    :goto_1
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$DatePatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-direct {v5, v6, v2}, Lorg/apache/log4j/helpers/PatternParser$DatePatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;Ljava/text/DateFormat;)V

    move-object v0, v5

    .line 278
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 279
    goto/16 :goto_2

    .line 234
    .end local v2    # "df":Ljava/text/DateFormat;
    .end local v3    # "dateFormatStr":Ljava/lang/String;
    .end local v4    # "dOpt":Ljava/lang/String;
    :sswitch_7
    new-instance v2, Lorg/apache/log4j/helpers/PatternParser$CategoryPatternConverter;

    iget-object v3, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-virtual {p0}, Lorg/apache/log4j/helpers/PatternParser;->extractPrecisionOption()I

    move-result v4

    invoke-direct {v2, p0, v3, v4}, Lorg/apache/log4j/helpers/PatternParser$CategoryPatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v2

    .line 238
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 239
    goto/16 :goto_2

    .line 232
    :sswitch_8
    move-object v3, v2

    .local v3, "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 353
    .local v2, "dOpt":Ljava/lang/String;
    .local v4, "dateFormatStr":Ljava/lang/String;
    invoke-virtual {p0}, Lorg/apache/log4j/helpers/PatternParser;->extractOption()Ljava/lang/String;

    move-result-object v5

    .line 354
    .local v5, "xOpt":Ljava/lang/String;
    new-instance v6, Lorg/apache/log4j/helpers/PatternParser$MDCPatternConverter;

    iget-object v7, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-direct {v6, v7, v5}, Lorg/apache/log4j/helpers/PatternParser$MDCPatternConverter;-><init>(Lorg/apache/log4j/helpers/FormattingInfo;Ljava/lang/String;)V

    move-object v0, v6

    .line 355
    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 356
    goto :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    .end local v5    # "xOpt":Ljava/lang/String;
    :sswitch_9
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 308
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x3e9

    invoke-direct {v5, p0, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 312
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 313
    goto :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_a
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 295
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x3eb

    invoke-direct {v5, p0, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 299
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 300
    goto :goto_2

    .line 232
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_b
    move-object v3, v2

    .restart local v3    # "df":Ljava/text/DateFormat;
    move-object v4, v2

    .line 281
    .restart local v2    # "dOpt":Ljava/lang/String;
    .restart local v4    # "dateFormatStr":Ljava/lang/String;
    new-instance v5, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;

    iget-object v6, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    const/16 v7, 0x3ec

    invoke-direct {v5, p0, v6, v7}, Lorg/apache/log4j/helpers/PatternParser$LocationPatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v5

    .line 285
    iget-object v5, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 286
    goto :goto_2

    .line 241
    .end local v2    # "dOpt":Ljava/lang/String;
    .end local v3    # "df":Ljava/text/DateFormat;
    .end local v4    # "dateFormatStr":Ljava/lang/String;
    :sswitch_c
    new-instance v2, Lorg/apache/log4j/helpers/PatternParser$ClassNamePatternConverter;

    iget-object v3, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-virtual {p0}, Lorg/apache/log4j/helpers/PatternParser;->extractPrecisionOption()I

    move-result v4

    invoke-direct {v2, p0, v3, v4}, Lorg/apache/log4j/helpers/PatternParser$ClassNamePatternConverter;-><init>(Lorg/apache/log4j/helpers/PatternParser;Lorg/apache/log4j/helpers/FormattingInfo;I)V

    move-object v0, v2

    .line 245
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 246
    nop

    .line 364
    :goto_2
    invoke-virtual {p0, v0}, Lorg/apache/log4j/helpers/PatternParser;->addConverter(Lorg/apache/log4j/helpers/PatternConverter;)V

    .line 365
    return-void

    :sswitch_data_0
    .sparse-switch
        0x43 -> :sswitch_c
        0x46 -> :sswitch_b
        0x4c -> :sswitch_a
        0x4d -> :sswitch_9
        0x58 -> :sswitch_8
        0x63 -> :sswitch_7
        0x64 -> :sswitch_6
        0x6c -> :sswitch_5
        0x6d -> :sswitch_4
        0x70 -> :sswitch_3
        0x72 -> :sswitch_2
        0x74 -> :sswitch_1
        0x78 -> :sswitch_0
    .end sparse-switch
.end method

.method public parse()Lorg/apache/log4j/helpers/PatternConverter;
    .locals 7

    .line 133
    const/4 v0, 0x0

    iput v0, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    .line 134
    :goto_0
    iget v1, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->patternLength:I

    if-ge v1, v2, :cond_8

    .line 135
    iget-object v1, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    add-int/lit8 v3, v2, 0x1

    iput v3, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v1

    .line 136
    .local v1, "c":C
    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    const/4 v3, 0x3

    const/16 v4, 0x39

    const/4 v5, 0x1

    const/16 v6, 0x30

    packed-switch v2, :pswitch_data_0

    :pswitch_0
    goto/16 :goto_2

    .line 212
    :pswitch_1
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 213
    if-lt v1, v6, :cond_0

    if-gt v1, v4, :cond_0

    .line 214
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    iget-object v3, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    iget v3, v3, Lorg/apache/log4j/helpers/FormattingInfo;->max:I

    mul-int/lit8 v3, v3, 0xa

    add-int/lit8 v4, v1, -0x30

    add-int/2addr v3, v4

    iput v3, v2, Lorg/apache/log4j/helpers/FormattingInfo;->max:I

    goto/16 :goto_2

    .line 216
    :cond_0
    invoke-virtual {p0, v1}, Lorg/apache/log4j/helpers/PatternParser;->finalizeConverter(C)V

    .line 217
    iput v0, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    goto/16 :goto_2

    .line 190
    :pswitch_2
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 191
    if-lt v1, v6, :cond_1

    if-gt v1, v4, :cond_1

    .line 192
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    iget-object v3, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    iget v3, v3, Lorg/apache/log4j/helpers/FormattingInfo;->min:I

    mul-int/lit8 v3, v3, 0xa

    add-int/lit8 v4, v1, -0x30

    add-int/2addr v3, v4

    iput v3, v2, Lorg/apache/log4j/helpers/FormattingInfo;->min:I

    goto/16 :goto_2

    .line 193
    :cond_1
    const/16 v2, 0x2e

    if-ne v1, v2, :cond_2

    .line 194
    iput v3, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    goto/16 :goto_2

    .line 196
    :cond_2
    invoke-virtual {p0, v1}, Lorg/apache/log4j/helpers/PatternParser;->finalizeConverter(C)V

    .line 198
    goto/16 :goto_2

    .line 200
    :pswitch_3
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 201
    if-lt v1, v6, :cond_3

    if-gt v1, v4, :cond_3

    .line 202
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    add-int/lit8 v3, v1, -0x30

    iput v3, v2, Lorg/apache/log4j/helpers/FormattingInfo;->max:I

    .line 203
    const/4 v2, 0x5

    iput v2, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    goto/16 :goto_2

    .line 206
    :cond_3
    new-instance v2, Ljava/lang/StringBuffer;

    invoke-direct {v2}, Ljava/lang/StringBuffer;-><init>()V

    const-string v3, "Error occured in position "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    iget v3, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, ".\n Was expecting digit, instead got char \""

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    move-result-object v2

    const-string v3, "\"."

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lorg/apache/log4j/helpers/LogLog;->error(Ljava/lang/String;)V

    .line 208
    iput v0, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    .line 210
    goto/16 :goto_2

    .line 172
    :pswitch_4
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 173
    packed-switch v1, :pswitch_data_1

    .line 181
    if-lt v1, v6, :cond_4

    if-gt v1, v4, :cond_4

    .line 182
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    add-int/lit8 v3, v1, -0x30

    iput v3, v2, Lorg/apache/log4j/helpers/FormattingInfo;->min:I

    .line 183
    const/4 v2, 0x4

    iput v2, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    goto/16 :goto_2

    .line 178
    :pswitch_5
    iput v3, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    .line 179
    goto :goto_2

    .line 175
    :pswitch_6
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    iput-boolean v5, v2, Lorg/apache/log4j/helpers/FormattingInfo;->leftAlign:Z

    .line 176
    goto :goto_2

    .line 186
    :cond_4
    invoke-virtual {p0, v1}, Lorg/apache/log4j/helpers/PatternParser;->finalizeConverter(C)V

    .line 188
    goto :goto_2

    .line 139
    :pswitch_7
    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    iget v3, p0, Lorg/apache/log4j/helpers/PatternParser;->patternLength:I

    if-ne v2, v3, :cond_5

    .line 140
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 141
    goto/16 :goto_0

    .line 143
    :cond_5
    const/16 v2, 0x25

    if-ne v1, v2, :cond_7

    .line 145
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->pattern:Ljava/lang/String;

    iget v3, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    invoke-virtual {v2, v3}, Ljava/lang/String;->charAt(I)C

    move-result v2

    sparse-switch v2, :sswitch_data_0

    .line 155
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->length()I

    move-result v2

    if-eqz v2, :cond_6

    .line 156
    new-instance v2, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;

    iget-object v3, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v3}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v2}, Lorg/apache/log4j/helpers/PatternParser;->addToList(Lorg/apache/log4j/helpers/PatternConverter;)V

    goto :goto_1

    .line 151
    :sswitch_0
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    sget-object v3, Lorg/apache/log4j/Layout;->LINE_SEP:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 152
    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    add-int/2addr v2, v5

    iput v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    .line 153
    goto :goto_2

    .line 147
    :sswitch_1
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 148
    iget v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    add-int/2addr v2, v5

    iput v2, p0, Lorg/apache/log4j/helpers/PatternParser;->i:I

    .line 149
    goto :goto_2

    .line 161
    :cond_6
    :goto_1
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuffer;->setLength(I)V

    .line 162
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 163
    iput v5, p0, Lorg/apache/log4j/helpers/PatternParser;->state:I

    .line 164
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->formattingInfo:Lorg/apache/log4j/helpers/FormattingInfo;

    invoke-virtual {v2}, Lorg/apache/log4j/helpers/FormattingInfo;->reset()V

    goto :goto_2

    .line 168
    :cond_7
    iget-object v2, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 170
    nop

    .line 219
    :goto_2
    goto/16 :goto_0

    .line 222
    .end local v1    # "c":C
    :cond_8
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v0}, Ljava/lang/StringBuffer;->length()I

    move-result v0

    if-eqz v0, :cond_9

    .line 223
    new-instance v0, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;

    iget-object v1, p0, Lorg/apache/log4j/helpers/PatternParser;->currentLiteral:Ljava/lang/StringBuffer;

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/log4j/helpers/PatternParser$LiteralPatternConverter;-><init>(Ljava/lang/String;)V

    invoke-direct {p0, v0}, Lorg/apache/log4j/helpers/PatternParser;->addToList(Lorg/apache/log4j/helpers/PatternConverter;)V

    .line 226
    :cond_9
    iget-object v0, p0, Lorg/apache/log4j/helpers/PatternParser;->head:Lorg/apache/log4j/helpers/PatternConverter;

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_7
        :pswitch_4
        :pswitch_0
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x2d
        :pswitch_6
        :pswitch_5
    .end packed-switch

    :sswitch_data_0
    .sparse-switch
        0x25 -> :sswitch_1
        0x6e -> :sswitch_0
    .end sparse-switch
.end method
