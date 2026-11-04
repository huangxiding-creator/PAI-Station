.class public Lorg/apache/log4j/helpers/ISO8601DateFormat;
.super Lorg/apache/log4j/helpers/AbsoluteTimeDateFormat;
.source "ISO8601DateFormat.java"


# static fields
.field private static lastTime:J = 0x0L

.field private static lastTimeString:[C = null

.field private static final serialVersionUID:J = -0xa8b7f21cd667ee0L


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 55
    const/16 v0, 0x14

    new-array v0, v0, [C

    sput-object v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTimeString:[C

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Lorg/apache/log4j/helpers/AbsoluteTimeDateFormat;-><init>()V

    .line 47
    return-void
.end method

.method public constructor <init>(Ljava/util/TimeZone;)V
    .locals 0
    .param p1, "timeZone"    # Ljava/util/TimeZone;

    .line 51
    invoke-direct {p0, p1}, Lorg/apache/log4j/helpers/AbsoluteTimeDateFormat;-><init>(Ljava/util/TimeZone;)V

    .line 52
    return-void
.end method


# virtual methods
.method public format(Ljava/util/Date;Ljava/lang/StringBuffer;Ljava/text/FieldPosition;)Ljava/lang/StringBuffer;
    .locals 16
    .param p1, "date"    # Ljava/util/Date;
    .param p2, "sbuf"    # Ljava/lang/StringBuffer;
    .param p3, "fieldPosition"    # Ljava/text/FieldPosition;

    .line 67
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    invoke-virtual/range {p1 .. p1}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    .line 68
    .local v2, "now":J
    const-wide/16 v4, 0x3e8

    rem-long v4, v2, v4

    long-to-int v4, v4

    .line 70
    .local v4, "millis":I
    int-to-long v5, v4

    sub-long v5, v2, v5

    sget-wide v7, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTime:J

    cmp-long v5, v5, v7

    const/4 v6, 0x0

    const/16 v7, 0xa

    const/16 v8, 0x30

    if-nez v5, :cond_1

    sget-object v5, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTimeString:[C

    aget-char v5, v5, v6

    if-nez v5, :cond_0

    goto :goto_0

    .line 134
    :cond_0
    sget-object v5, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTimeString:[C

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append([C)Ljava/lang/StringBuffer;

    move-object/from16 v9, p1

    goto/16 :goto_2

    .line 75
    :cond_1
    :goto_0
    iget-object v5, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    move-object/from16 v9, p1

    invoke-virtual {v5, v9}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 77
    invoke-virtual/range {p2 .. p2}, Ljava/lang/StringBuffer;->length()I

    move-result v5

    .line 79
    .local v5, "start":I
    iget-object v10, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/4 v11, 0x1

    invoke-virtual {v10, v11}, Ljava/util/Calendar;->get(I)I

    move-result v10

    .line 80
    .local v10, "year":I
    invoke-virtual {v1, v10}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 83
    iget-object v11, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/4 v12, 0x2

    invoke-virtual {v11, v12}, Ljava/util/Calendar;->get(I)I

    move-result v11

    const/4 v12, 0x0

    packed-switch v11, :pswitch_data_0

    move-object v11, v12

    .line 96
    .local v11, "month":Ljava/lang/String;
    const-string v11, "-NA-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_0
    move-object v11, v12

    .line 95
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-12-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_1
    move-object v11, v12

    .line 94
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-11-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_2
    move-object v11, v12

    .line 93
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-10-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_3
    move-object v11, v12

    .line 92
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-09-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_4
    move-object v11, v12

    .line 91
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-08-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_5
    move-object v11, v12

    .line 90
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-07-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_6
    move-object v11, v12

    .line 89
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-06-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_7
    move-object v11, v12

    .line 88
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-05-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_8
    move-object v11, v12

    .line 87
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-04-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_9
    move-object v11, v12

    .line 86
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-03-"

    goto :goto_1

    .line 83
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_a
    move-object v11, v12

    .line 85
    .restart local v11    # "month":Ljava/lang/String;
    const-string v11, "-02-"

    goto :goto_1

    .line 84
    .end local v11    # "month":Ljava/lang/String;
    :pswitch_b
    const-string v11, "-01-"

    .line 98
    .restart local v11    # "month":Ljava/lang/String;
    :goto_1
    invoke-virtual {v1, v11}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 100
    iget-object v12, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/4 v13, 0x5

    invoke-virtual {v12, v13}, Ljava/util/Calendar;->get(I)I

    move-result v12

    .line 101
    .local v12, "day":I
    if-ge v12, v7, :cond_2

    .line 102
    invoke-virtual {v1, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 103
    :cond_2
    invoke-virtual {v1, v12}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 105
    const/16 v13, 0x20

    invoke-virtual {v1, v13}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 107
    iget-object v13, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/16 v14, 0xb

    invoke-virtual {v13, v14}, Ljava/util/Calendar;->get(I)I

    move-result v13

    .line 108
    .local v13, "hour":I
    if-ge v13, v7, :cond_3

    .line 109
    invoke-virtual {v1, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 111
    :cond_3
    invoke-virtual {v1, v13}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 112
    const/16 v14, 0x3a

    invoke-virtual {v1, v14}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 114
    iget-object v15, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/16 v6, 0xc

    invoke-virtual {v15, v6}, Ljava/util/Calendar;->get(I)I

    move-result v6

    .line 115
    .local v6, "mins":I
    if-ge v6, v7, :cond_4

    .line 116
    invoke-virtual {v1, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 118
    :cond_4
    invoke-virtual {v1, v6}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 119
    invoke-virtual {v1, v14}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 121
    iget-object v14, v0, Lorg/apache/log4j/helpers/ISO8601DateFormat;->calendar:Ljava/util/Calendar;

    const/16 v15, 0xd

    invoke-virtual {v14, v15}, Ljava/util/Calendar;->get(I)I

    move-result v14

    .line 122
    .local v14, "secs":I
    if-ge v14, v7, :cond_5

    .line 123
    invoke-virtual {v1, v8}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 125
    :cond_5
    invoke-virtual {v1, v14}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 127
    const/16 v15, 0x2c

    invoke-virtual {v1, v15}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 130
    invoke-virtual/range {p2 .. p2}, Ljava/lang/StringBuffer;->length()I

    move-result v15

    sget-object v7, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTimeString:[C

    const/4 v8, 0x0

    invoke-virtual {v1, v5, v15, v7, v8}, Ljava/lang/StringBuffer;->getChars(II[CI)V

    .line 131
    int-to-long v7, v4

    sub-long v7, v2, v7

    sput-wide v7, Lorg/apache/log4j/helpers/ISO8601DateFormat;->lastTime:J

    .line 132
    .end local v5    # "start":I
    .end local v6    # "mins":I
    .end local v10    # "year":I
    .end local v11    # "month":Ljava/lang/String;
    .end local v12    # "day":I
    .end local v13    # "hour":I
    .end local v14    # "secs":I
    nop

    .line 138
    :goto_2
    const/16 v5, 0x64

    if-ge v4, v5, :cond_6

    .line 139
    const/16 v5, 0x30

    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_3

    .line 138
    :cond_6
    const/16 v5, 0x30

    .line 140
    :goto_3
    const/16 v6, 0xa

    if-ge v4, v6, :cond_7

    .line 141
    invoke-virtual {v1, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 143
    :cond_7
    invoke-virtual {v1, v4}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 144
    return-object v1

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public parse(Ljava/lang/String;Ljava/text/ParsePosition;)Ljava/util/Date;
    .locals 1
    .param p1, "s"    # Ljava/lang/String;
    .param p2, "pos"    # Ljava/text/ParsePosition;

    .line 152
    const/4 v0, 0x0

    return-object v0
.end method
