.class public Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;
.super Ljava/lang/Object;
.source "RKLogger.java"


# static fields
.field private static FILTER_LEVEL:I

.field private static TAG:Ljava/lang/String;

.field private static isTAGSettable:Ljava/util/concurrent/atomic/AtomicBoolean;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 15
    const/4 v0, 0x1

    sput v0, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->FILTER_LEVEL:I

    .line 16
    const-string v1, "Rokid_Logger"

    sput-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    .line 18
    new-instance v1, Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-direct {v1, v0}, Ljava/util/concurrent/atomic/AtomicBoolean;-><init>(Z)V

    sput-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->isTAGSettable:Ljava/util/concurrent/atomic/AtomicBoolean;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static varargs d(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 119
    const/4 v0, 0x2

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 120
    return-void
.end method

.method public static varargs dWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 123
    const/4 v0, 0x2

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    return-void
.end method

.method public static varargs debug(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 159
    const/4 v0, 0x2

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 160
    return-void
.end method

.method public static varargs e(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 143
    const/4 v0, 0x5

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 144
    return-void
.end method

.method public static varargs eWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 147
    const/4 v0, 0x5

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 148
    return-void
.end method

.method public static varargs error(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 171
    const/4 v0, 0x5

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 172
    return-void
.end method

.method public static varargs i(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 127
    const/4 v0, 0x3

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 128
    return-void
.end method

.method public static varargs iWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 131
    const/4 v0, 0x3

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 132
    return-void
.end method

.method public static varargs info(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 163
    const/4 v0, 0x3

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 164
    return-void
.end method

.method private static varargs printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 5
    .param p0, "level"    # I
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "message"    # Ljava/lang/String;
    .param p3, "args"    # [Ljava/lang/Object;

    .line 38
    sget v0, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->FILTER_LEVEL:I

    if-ge p0, v0, :cond_0

    .line 39
    return-void

    .line 42
    :cond_0
    const/4 v0, 0x0

    .line 43
    .local v0, "throwable":Ljava/lang/Throwable;
    move-object v1, p2

    .line 46
    .local v1, "formattedMessage":Ljava/lang/String;
    array-length v2, p3

    if-lez v2, :cond_1

    array-length v2, p3

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    aget-object v2, p3, v2

    instance-of v2, v2, Ljava/lang/Throwable;

    if-eqz v2, :cond_1

    .line 47
    array-length v2, p3

    sub-int/2addr v2, v3

    aget-object v2, p3, v2

    move-object v0, v2

    check-cast v0, Ljava/lang/Throwable;

    .line 49
    array-length v2, p3

    if-le v2, v3, :cond_2

    .line 50
    array-length v2, p3

    sub-int/2addr v2, v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 51
    .local v2, "formatArgs":[Ljava/lang/Object;
    array-length v4, p3

    sub-int/2addr v4, v3

    const/4 v3, 0x0

    invoke-static {p3, v3, v2, v3, v4}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 52
    invoke-static {p2, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 53
    .end local v2    # "formatArgs":[Ljava/lang/Object;
    goto :goto_0

    .line 54
    :cond_1
    array-length v2, p3

    if-lez v2, :cond_2

    .line 55
    invoke-static {p2, p3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 58
    :cond_2
    :goto_0
    packed-switch p0, :pswitch_data_0

    .line 95
    if-eqz v0, :cond_8

    .line 96
    invoke-static {p1, v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 88
    :pswitch_0
    if-eqz v0, :cond_3

    .line 89
    invoke-static {p1, v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 91
    :cond_3
    invoke-static {p1, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 93
    goto :goto_1

    .line 81
    :pswitch_1
    if-eqz v0, :cond_4

    .line 82
    invoke-static {p1, v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 84
    :cond_4
    invoke-static {p1, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 86
    goto :goto_1

    .line 74
    :pswitch_2
    if-eqz v0, :cond_5

    .line 75
    invoke-static {p1, v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 77
    :cond_5
    invoke-static {p1, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 79
    goto :goto_1

    .line 67
    :pswitch_3
    if-eqz v0, :cond_6

    .line 68
    invoke-static {p1, v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 70
    :cond_6
    invoke-static {p1, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 72
    goto :goto_1

    .line 60
    :pswitch_4
    if-eqz v0, :cond_7

    .line 61
    invoke-static {p1, v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 63
    :cond_7
    invoke-static {p1, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 65
    goto :goto_1

    .line 98
    :cond_8
    invoke-static {p1, v1}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 102
    :goto_1
    return-void

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static declared-synchronized setTAG(Ljava/lang/String;I)V
    .locals 3
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "filterLevel"    # I

    const-class v0, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;

    monitor-enter v0

    .line 21
    :try_start_0
    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->isTAGSettable:Ljava/util/concurrent/atomic/AtomicBoolean;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicBoolean;->get()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 22
    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->isTAGSettable:Ljava/util/concurrent/atomic/AtomicBoolean;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicBoolean;->set(Z)V

    .line 23
    sput-object p0, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    .line 24
    sput p1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->FILTER_LEVEL:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 26
    :cond_0
    monitor-exit v0

    return-void

    .line 20
    .end local p0    # "tag":Ljava/lang/String;
    .end local p1    # "filterLevel":I
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method public static varargs v(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 111
    const/4 v0, 0x1

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 112
    return-void
.end method

.method public static varargs vWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 115
    const/4 v0, 0x1

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 116
    return-void
.end method

.method public static varargs verbose(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 155
    const/4 v0, 0x1

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 156
    return-void
.end method

.method public static varargs w(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 135
    const/4 v0, 0x4

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 136
    return-void
.end method

.method public static varargs wWithTag(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 1
    .param p0, "tag"    # Ljava/lang/String;
    .param p1, "message"    # Ljava/lang/String;
    .param p2, "args"    # [Ljava/lang/Object;

    .line 139
    const/4 v0, 0x4

    invoke-static {v0, p0, p1, p2}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 140
    return-void
.end method

.method public static varargs warning(Ljava/lang/String;[Ljava/lang/Object;)V
    .locals 2
    .param p0, "message"    # Ljava/lang/String;
    .param p1, "args"    # [Ljava/lang/Object;

    .line 167
    const/4 v0, 0x4

    sget-object v1, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->TAG:Ljava/lang/String;

    invoke-static {v0, v1, p0, p1}, Lcom/rokid/sprite/aiapp/rfmlite/RKLogger;->printLog(ILjava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 168
    return-void
.end method
