.class public final Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;
.super Ljava/lang/Object;
.source "TrackModel.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000,\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\r\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u0087\u0008\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\t\u0010\u000f\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0010\u001a\u00020\u0005H\u00c6\u0003J\u001d\u0010\u0011\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005H\u00c6\u0001J\u0013\u0010\u0012\u001a\u00020\u00132\u0008\u0010\u0014\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0015\u001a\u00020\u0016H\u00d6\u0001J\t\u0010\u0017\u001a\u00020\u0018H\u00d6\u0001R\u001a\u0010\u0002\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\nR\u001a\u0010\u0004\u001a\u00020\u0005X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u0019"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;",
        "",
        "lprTrack",
        "Lcom/rokid/security/sdk/base/common/outside/LPRTrack;",
        "personCheckInfo",
        "Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
        "(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)V",
        "getLprTrack",
        "()Lcom/rokid/security/sdk/base/common/outside/LPRTrack;",
        "setLprTrack",
        "(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;)V",
        "getPersonCheckInfo",
        "()Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;",
        "setPersonCheckInfo",
        "(Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)V",
        "component1",
        "component2",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "",
        "toString",
        "",
        "sdk-base-common_release"
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
.field private lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

.field private personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;


# direct methods
.method public constructor <init>(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)V
    .locals 1
    .param p1, "lprTrack"    # Lcom/rokid/security/sdk/base/common/outside/LPRTrack;
    .param p2, "personCheckInfo"    # Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    const-string v0, "lprTrack"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personCheckInfo"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 34
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    .line 37
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    .line 35
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;ILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;
    .locals 0

    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    iget-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    iget-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->copy(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Lcom/rokid/security/sdk/base/common/outside/LPRTrack;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    return-object v0
.end method

.method public final component2()Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    return-object v0
.end method

.method public final copy(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;
    .locals 1

    const-string v0, "lprTrack"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personCheckInfo"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;

    invoke-direct {v0, p1, p2}, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;-><init>(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    iget-object v1, v1, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return v2

    :cond_3
    return v0
.end method

.method public final getLprTrack()Lcom/rokid/security/sdk/base/common/outside/LPRTrack;
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    return-object v0
.end method

.method public final getPersonCheckInfo()Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/outside/LPRTrack;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public final setLprTrack(Lcom/rokid/security/sdk/base/common/outside/LPRTrack;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    return-void
.end method

.method public final setPersonCheckInfo(Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 37
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "LPRIdentifyInfo(lprTrack="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->lprTrack:Lcom/rokid/security/sdk/base/common/outside/LPRTrack;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", personCheckInfo="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/LPRIdentifyInfo;->personCheckInfo:Lcom/rokid/security/sdk/base/common/out/PersonCheckInfo;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
