.class public final Lcom/rokid/security/sdk/ability/bean/BaseConfig;
.super Ljava/lang/Object;
.source "BaseConfig.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0008\n\u0002\u0010\u000e\n\u0002\u0008\u0017\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011R\u001a\u0010\u0012\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u0006\"\u0004\u0008\u0014\u0010\u0008R\u001a\u0010\u0015\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0016\u0010\u0006\"\u0004\u0008\u0017\u0010\u0008R\u001a\u0010\u0018\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0019\u0010\u0006\"\u0004\u0008\u001a\u0010\u0008R\u001c\u0010\u001b\u001a\u0004\u0018\u00010\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001c\u0010\u000f\"\u0004\u0008\u001d\u0010\u0011R\u001a\u0010\u001e\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u001f\u0010\u000f\"\u0004\u0008 \u0010\u0011R\u001a\u0010!\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\"\u0010\u0006\"\u0004\u0008#\u0010\u0008\u00a8\u0006$"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/bean/BaseConfig;",
        "",
        "()V",
        "bits",
        "",
        "getBits",
        "()I",
        "setBits",
        "(I)V",
        "channel",
        "getChannel",
        "setChannel",
        "formatName",
        "",
        "getFormatName",
        "()Ljava/lang/String;",
        "setFormatName",
        "(Ljava/lang/String;)V",
        "pitch",
        "getPitch",
        "setPitch",
        "rate",
        "getRate",
        "setRate",
        "sampleRate",
        "getSampleRate",
        "setSampleRate",
        "serverUrl",
        "getServerUrl",
        "setServerUrl",
        "version",
        "getVersion",
        "setVersion",
        "volume",
        "getVolume",
        "setVolume",
        "sdk-common-ability_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private bits:I

.field private channel:I

.field private formatName:Ljava/lang/String;

.field private pitch:I

.field private rate:I

.field private sampleRate:I

.field private serverUrl:Ljava/lang/String;

.field private version:Ljava/lang/String;

.field private volume:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const-string/jumbo v0, "v1"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->version:Ljava/lang/String;

    .line 12
    const-string v0, "pcm"

    iput-object v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->formatName:Ljava/lang/String;

    .line 13
    const/16 v0, 0x3e80

    iput v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->sampleRate:I

    .line 14
    const/16 v0, 0x10

    iput v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->bits:I

    .line 15
    const/4 v0, 0x1

    iput v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->channel:I

    .line 17
    const/16 v1, 0x32

    iput v1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->volume:I

    .line 18
    iput v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->rate:I

    .line 19
    iput v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->pitch:I

    .line 7
    return-void
.end method


# virtual methods
.method public final getBits()I
    .locals 1

    .line 14
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->bits:I

    return v0
.end method

.method public final getChannel()I
    .locals 1

    .line 15
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->channel:I

    return v0
.end method

.method public final getFormatName()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->formatName:Ljava/lang/String;

    return-object v0
.end method

.method public final getPitch()I
    .locals 1

    .line 19
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->pitch:I

    return v0
.end method

.method public final getRate()I
    .locals 1

    .line 18
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->rate:I

    return v0
.end method

.method public final getSampleRate()I
    .locals 1

    .line 13
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->sampleRate:I

    return v0
.end method

.method public final getServerUrl()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->serverUrl:Ljava/lang/String;

    return-object v0
.end method

.method public final getVersion()Ljava/lang/String;
    .locals 1

    .line 10
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->version:Ljava/lang/String;

    return-object v0
.end method

.method public final getVolume()I
    .locals 1

    .line 17
    iget v0, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->volume:I

    return v0
.end method

.method public final setBits(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 14
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->bits:I

    return-void
.end method

.method public final setChannel(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 15
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->channel:I

    return-void
.end method

.method public final setFormatName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->formatName:Ljava/lang/String;

    return-void
.end method

.method public final setPitch(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 19
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->pitch:I

    return-void
.end method

.method public final setRate(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 18
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->rate:I

    return-void
.end method

.method public final setSampleRate(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 13
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->sampleRate:I

    return-void
.end method

.method public final setServerUrl(Ljava/lang/String;)V
    .locals 0
    .param p1, "<set-?>"    # Ljava/lang/String;

    .line 9
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->serverUrl:Ljava/lang/String;

    return-void
.end method

.method public final setVersion(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 10
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->version:Ljava/lang/String;

    return-void
.end method

.method public final setVolume(I)V
    .locals 0
    .param p1, "<set-?>"    # I

    .line 17
    iput p1, p0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->volume:I

    return-void
.end method
