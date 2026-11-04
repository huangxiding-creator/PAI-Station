.class public final Lorg/apache/log4j/pattern/DatePatternConverter;
.super Lorg/apache/log4j/pattern/LoggingEventPatternConverter;
.source "DatePatternConverter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/apache/log4j/pattern/DatePatternConverter$DefaultZoneDateFormat;
    }
.end annotation


# static fields
.field private static final ABSOLUTE_FORMAT:Ljava/lang/String; = "ABSOLUTE"

.field private static final ABSOLUTE_TIME_PATTERN:Ljava/lang/String; = "HH:mm:ss,SSS"

.field private static final DATE_AND_TIME_FORMAT:Ljava/lang/String; = "DATE"

.field private static final DATE_AND_TIME_PATTERN:Ljava/lang/String; = "dd MMM yyyy HH:mm:ss,SSS"

.field private static final ISO8601_FORMAT:Ljava/lang/String; = "ISO8601"

.field private static final ISO8601_PATTERN:Ljava/lang/String; = "yyyy-MM-dd HH:mm:ss,SSS"


# instance fields
.field private final df:Lorg/apache/log4j/pattern/CachedDateFormat;


# direct methods
.method private constructor <init>([Ljava/lang/String;)V
    .locals 7
    .param p1, "options"    # [Ljava/lang/String;

    .line 113
    const-string v0, "Date"

    const-string v1, "date"

    invoke-direct {p0, v0, v1}, Lorg/apache/log4j/pattern/LoggingEventPatternConverter;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 117
    if-eqz p1, :cond_1

    array-length v0, p1

    if-nez v0, :cond_0

    goto :goto_0

    .line 122
    :cond_0
    const/4 v0, 0x0

    aget-object v0, p1, v0

    .local v0, "patternOption":Ljava/lang/String;
    goto :goto_1

    .line 120
    .end local v0    # "patternOption":Ljava/lang/String;
    :cond_1
    :goto_0
    const/4 v0, 0x0

    .line 127
    .restart local v0    # "patternOption":Ljava/lang/String;
    :goto_1
    if-eqz v0, :cond_5

    const-string v1, "ISO8601"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    goto :goto_2

    .line 131
    :cond_2
    const-string v1, "ABSOLUTE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 132
    const-string v1, "HH:mm:ss,SSS"

    .local v1, "pattern":Ljava/lang/String;
    goto :goto_3

    .line 133
    .end local v1    # "pattern":Ljava/lang/String;
    :cond_3
    const-string v1, "DATE"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 134
    const-string v1, "dd MMM yyyy HH:mm:ss,SSS"

    .restart local v1    # "pattern":Ljava/lang/String;
    goto :goto_3

    .line 136
    .end local v1    # "pattern":Ljava/lang/String;
    :cond_4
    move-object v1, v0

    .restart local v1    # "pattern":Ljava/lang/String;
    goto :goto_3

    .line 130
    .end local v1    # "pattern":Ljava/lang/String;
    :cond_5
    :goto_2
    const-string/jumbo v1, "yyyy-MM-dd HH:mm:ss,SSS"

    .line 139
    .restart local v1    # "pattern":Ljava/lang/String;
    :goto_3
    const/16 v2, 0x3e8

    .line 140
    .local v2, "maximumCacheValidity":I
    const/4 v3, 0x0

    .line 143
    .local v3, "simpleFormat":Ljava/text/DateFormat;
    :try_start_0
    new-instance v4, Ljava/text/SimpleDateFormat;

    invoke-direct {v4, v1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    move-object v3, v4

    .line 144
    invoke-static {v1}, Lorg/apache/log4j/pattern/CachedDateFormat;->getMaximumCacheValidity(Ljava/lang/String;)I

    move-result v4
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v4

    .line 152
    goto :goto_4

    .line 145
    :catch_0
    move-exception v4

    .line 146
    .local v4, "e":Ljava/lang/IllegalArgumentException;
    new-instance v5, Ljava/lang/StringBuffer;

    invoke-direct {v5}, Ljava/lang/StringBuffer;-><init>()V

    const-string v6, "Could not instantiate SimpleDateFormat with pattern "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5, v4}, Lorg/apache/log4j/helpers/LogLog;->warn(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 151
    new-instance v5, Ljava/text/SimpleDateFormat;

    const-string/jumbo v6, "yyyy-MM-dd HH:mm:ss,SSS"

    invoke-direct {v5, v6}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    move-object v3, v5

    .line 155
    .end local v4    # "e":Ljava/lang/IllegalArgumentException;
    :goto_4
    if-eqz p1, :cond_6

    array-length v4, p1

    const/4 v5, 0x1

    if-le v4, v5, :cond_6

    .line 156
    aget-object v4, p1, v5

    invoke-static {v4}, Ljava/util/TimeZone;->getTimeZone(Ljava/lang/String;)Ljava/util/TimeZone;

    move-result-object v4

    .line 157
    .local v4, "tz":Ljava/util/TimeZone;
    invoke-virtual {v3, v4}, Ljava/text/DateFormat;->setTimeZone(Ljava/util/TimeZone;)V

    .line 158
    .end local v4    # "tz":Ljava/util/TimeZone;
    goto :goto_5

    .line 159
    :cond_6
    new-instance v4, Lorg/apache/log4j/pattern/DatePatternConverter$DefaultZoneDateFormat;

    invoke-direct {v4, v3}, Lorg/apache/log4j/pattern/DatePatternConverter$DefaultZoneDateFormat;-><init>(Ljava/text/DateFormat;)V

    move-object v3, v4

    .line 162
    :goto_5
    new-instance v4, Lorg/apache/log4j/pattern/CachedDateFormat;

    invoke-direct {v4, v3, v2}, Lorg/apache/log4j/pattern/CachedDateFormat;-><init>(Ljava/text/DateFormat;I)V

    iput-object v4, p0, Lorg/apache/log4j/pattern/DatePatternConverter;->df:Lorg/apache/log4j/pattern/CachedDateFormat;

    .line 163
    return-void
.end method

.method public static newInstance([Ljava/lang/String;)Lorg/apache/log4j/pattern/DatePatternConverter;
    .locals 1
    .param p0, "options"    # [Ljava/lang/String;

    .line 172
    new-instance v0, Lorg/apache/log4j/pattern/DatePatternConverter;

    invoke-direct {v0, p0}, Lorg/apache/log4j/pattern/DatePatternConverter;-><init>([Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public format(Ljava/lang/Object;Ljava/lang/StringBuffer;)V
    .locals 1
    .param p1, "obj"    # Ljava/lang/Object;
    .param p2, "output"    # Ljava/lang/StringBuffer;

    .line 188
    instance-of v0, p1, Ljava/util/Date;

    if-eqz v0, :cond_0

    .line 189
    move-object v0, p1

    check-cast v0, Ljava/util/Date;

    invoke-virtual {p0, v0, p2}, Lorg/apache/log4j/pattern/DatePatternConverter;->format(Ljava/util/Date;Ljava/lang/StringBuffer;)V

    .line 192
    :cond_0
    invoke-super {p0, p1, p2}, Lorg/apache/log4j/pattern/LoggingEventPatternConverter;->format(Ljava/lang/Object;Ljava/lang/StringBuffer;)V

    .line 193
    return-void
.end method

.method public format(Ljava/util/Date;Ljava/lang/StringBuffer;)V
    .locals 3
    .param p1, "date"    # Ljava/util/Date;
    .param p2, "toAppendTo"    # Ljava/lang/StringBuffer;

    .line 201
    monitor-enter p0

    .line 202
    :try_start_0
    iget-object v0, p0, Lorg/apache/log4j/pattern/DatePatternConverter;->df:Lorg/apache/log4j/pattern/CachedDateFormat;

    invoke-virtual {p1}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    invoke-virtual {v0, v1, v2, p2}, Lorg/apache/log4j/pattern/CachedDateFormat;->format(JLjava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    .line 203
    monitor-exit p0

    .line 204
    return-void

    .line 203
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public format(Lorg/apache/log4j/spi/LoggingEvent;Ljava/lang/StringBuffer;)V
    .locals 3
    .param p1, "event"    # Lorg/apache/log4j/spi/LoggingEvent;
    .param p2, "output"    # Ljava/lang/StringBuffer;

    .line 179
    monitor-enter p0

    .line 180
    :try_start_0
    iget-object v0, p0, Lorg/apache/log4j/pattern/DatePatternConverter;->df:Lorg/apache/log4j/pattern/CachedDateFormat;

    iget-wide v1, p1, Lorg/apache/log4j/spi/LoggingEvent;->timeStamp:J

    invoke-virtual {v0, v1, v2, p2}, Lorg/apache/log4j/pattern/CachedDateFormat;->format(JLjava/lang/StringBuffer;)Ljava/lang/StringBuffer;

    .line 181
    monitor-exit p0

    .line 182
    return-void

    .line 181
    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method
