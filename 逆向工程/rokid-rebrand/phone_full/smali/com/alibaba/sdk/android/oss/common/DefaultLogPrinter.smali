.class public Lcom/alibaba/sdk/android/oss/common/DefaultLogPrinter;
.super Ljava/lang/Object;
.source "DefaultLogPrinter.java"

# interfaces
.implements Lcom/alibaba/sdk/android/oss/common/LogPrinter;


# static fields
.field private static final TAG:Ljava/lang/String; = "OSS-Android-SDK"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public log(Lcom/alibaba/sdk/android/oss/common/LogLevel;Ljava/lang/String;)V
    .locals 2
    .param p1, "level"    # Lcom/alibaba/sdk/android/oss/common/LogLevel;
    .param p2, "message"    # Ljava/lang/String;

    .line 11
    sget-object v0, Lcom/alibaba/sdk/android/oss/common/DefaultLogPrinter$1;->$SwitchMap$com$alibaba$sdk$android$oss$common$LogLevel:[I

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/oss/common/LogLevel;->ordinal()I

    move-result v1

    aget v0, v0, v1

    const-string v1, "OSS-Android-SDK"

    packed-switch v0, :pswitch_data_0

    goto :goto_0

    .line 25
    :pswitch_0
    const-string v0, "[ERROR]: "

    invoke-virtual {v0, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 22
    :pswitch_1
    const-string v0, "[DEBUG]: "

    invoke-virtual {v0, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 23
    goto :goto_0

    .line 19
    :pswitch_2
    const-string v0, "[WARN]: "

    invoke-virtual {v0, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 20
    goto :goto_0

    .line 16
    :pswitch_3
    const-string v0, "[VERBOSE]: "

    invoke-virtual {v0, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->v(Ljava/lang/String;Ljava/lang/String;)I

    .line 17
    goto :goto_0

    .line 13
    :pswitch_4
    const-string v0, "[INFO]: "

    invoke-virtual {v0, p2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 14
    nop

    .line 28
    :goto_0
    return-void

    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
