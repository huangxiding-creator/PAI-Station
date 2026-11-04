.class Lorg/apache/log4j/RollingCalendar;
.super Ljava/util/GregorianCalendar;
.source "DailyRollingFileAppender.java"


# static fields
.field private static final serialVersionUID:J = -0x3168d6e1c54238a1L


# instance fields
.field type:I


# direct methods
.method constructor <init>()V
    .locals 1

    .line 384
    invoke-direct {p0}, Ljava/util/GregorianCalendar;-><init>()V

    .line 381
    const/4 v0, -0x1

    iput v0, p0, Lorg/apache/log4j/RollingCalendar;->type:I

    .line 385
    return-void
.end method

.method constructor <init>(Ljava/util/TimeZone;Ljava/util/Locale;)V
    .locals 1
    .param p1, "tz"    # Ljava/util/TimeZone;
    .param p2, "locale"    # Ljava/util/Locale;

    .line 388
    invoke-direct {p0, p1, p2}, Ljava/util/GregorianCalendar;-><init>(Ljava/util/TimeZone;Ljava/util/Locale;)V

    .line 381
    const/4 v0, -0x1

    iput v0, p0, Lorg/apache/log4j/RollingCalendar;->type:I

    .line 389
    return-void
.end method


# virtual methods
.method public getNextCheckDate(Ljava/util/Date;)Ljava/util/Date;
    .locals 9
    .param p1, "now"    # Ljava/util/Date;

    .line 400
    invoke-virtual {p0, p1}, Lorg/apache/log4j/RollingCalendar;->setTime(Ljava/util/Date;)V

    .line 402
    iget v0, p0, Lorg/apache/log4j/RollingCalendar;->type:I

    const/4 v1, 0x5

    const/16 v2, 0xe

    const/16 v3, 0xd

    const/16 v4, 0xb

    const/4 v5, 0x1

    const/16 v6, 0xc

    const/4 v7, 0x0

    const/4 v8, 0x0

    packed-switch v0, :pswitch_data_0

    move v0, v8

    .line 450
    .local v0, "hour":I
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Unknown periodicity type."

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 402
    .end local v0    # "hour":I
    :pswitch_0
    move v0, v8

    .line 442
    .restart local v0    # "hour":I
    invoke-virtual {p0, v1, v5}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 443
    invoke-virtual {p0, v4, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 444
    invoke-virtual {p0, v6, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 445
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 446
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 447
    const/4 v1, 0x2

    invoke-virtual {p0, v1, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 448
    goto :goto_0

    .line 402
    .end local v0    # "hour":I
    :pswitch_1
    move v0, v8

    .line 434
    .restart local v0    # "hour":I
    const/4 v1, 0x7

    invoke-virtual {p0}, Lorg/apache/log4j/RollingCalendar;->getFirstDayOfWeek()I

    move-result v8

    invoke-virtual {p0, v1, v8}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 435
    invoke-virtual {p0, v4, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 436
    invoke-virtual {p0, v6, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 437
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 438
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 439
    const/4 v1, 0x3

    invoke-virtual {p0, v1, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 440
    goto :goto_0

    .line 402
    .end local v0    # "hour":I
    :pswitch_2
    move v0, v8

    .line 427
    .restart local v0    # "hour":I
    invoke-virtual {p0, v4, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 428
    invoke-virtual {p0, v6, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 429
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 430
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 431
    invoke-virtual {p0, v1, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 432
    goto :goto_0

    .line 415
    .end local v0    # "hour":I
    :pswitch_3
    invoke-virtual {p0, v6, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 416
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 417
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 418
    invoke-virtual {p0, v4}, Lorg/apache/log4j/RollingCalendar;->get(I)I

    move-result v0

    .line 419
    .restart local v0    # "hour":I
    if-ge v0, v6, :cond_0

    .line 420
    invoke-virtual {p0, v4, v6}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    goto :goto_0

    .line 422
    :cond_0
    invoke-virtual {p0, v4, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 423
    invoke-virtual {p0, v1, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 425
    goto :goto_0

    .line 409
    .end local v0    # "hour":I
    :pswitch_4
    invoke-virtual {p0, v6, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 410
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 411
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 412
    invoke-virtual {p0, v4, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 413
    goto :goto_0

    .line 404
    :pswitch_5
    invoke-virtual {p0, v3, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 405
    invoke-virtual {p0, v2, v7}, Lorg/apache/log4j/RollingCalendar;->set(II)V

    .line 406
    invoke-virtual {p0, v6, v5}, Lorg/apache/log4j/RollingCalendar;->add(II)V

    .line 407
    nop

    .line 452
    :goto_0
    invoke-virtual {p0}, Lorg/apache/log4j/RollingCalendar;->getTime()Ljava/util/Date;

    move-result-object v0

    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public getNextCheckMillis(Ljava/util/Date;)J
    .locals 2
    .param p1, "now"    # Ljava/util/Date;

    .line 396
    invoke-virtual {p0, p1}, Lorg/apache/log4j/RollingCalendar;->getNextCheckDate(Ljava/util/Date;)Ljava/util/Date;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Date;->getTime()J

    move-result-wide v0

    return-wide v0
.end method

.method setType(I)V
    .locals 0
    .param p1, "type"    # I

    .line 392
    iput p1, p0, Lorg/apache/log4j/RollingCalendar;->type:I

    .line 393
    return-void
.end method
