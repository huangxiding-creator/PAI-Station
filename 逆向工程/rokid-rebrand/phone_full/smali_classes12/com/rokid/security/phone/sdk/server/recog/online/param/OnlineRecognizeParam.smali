.class public final Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;
.super Ljava/lang/Object;
.source "RequestParam.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0013\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001B%\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0003\u0012\u0006\u0010\u0005\u001a\u00020\u0003\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0002\u0010\u0008J\t\u0010\u0015\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0016\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0017\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u0018\u001a\u00020\u0007H\u00c6\u0003J1\u0010\u0019\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0005\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007H\u00c6\u0001J\u0013\u0010\u001a\u001a\u00020\u001b2\u0008\u0010\u001c\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u001d\u001a\u00020\u001eH\u00d6\u0001J\t\u0010\u001f\u001a\u00020\u0003H\u00d6\u0001R\u001a\u0010\u0006\u001a\u00020\u0007X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\t\u0010\n\"\u0004\u0008\u000b\u0010\u000cR\u001a\u0010\u0002\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\r\u0010\u000e\"\u0004\u0008\u000f\u0010\u0010R\u001a\u0010\u0005\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0011\u0010\u000e\"\u0004\u0008\u0012\u0010\u0010R\u001a\u0010\u0004\u001a\u00020\u0003X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0013\u0010\u000e\"\u0004\u0008\u0014\u0010\u0010\u00a8\u0006 "
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;",
        "",
        "imageBase64",
        "",
        "similarity",
        "personId",
        "device_meta",
        "Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V",
        "getDevice_meta",
        "()Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;",
        "setDevice_meta",
        "(Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V",
        "getImageBase64",
        "()Ljava/lang/String;",
        "setImageBase64",
        "(Ljava/lang/String;)V",
        "getPersonId",
        "setPersonId",
        "getSimilarity",
        "setSimilarity",
        "component1",
        "component2",
        "component3",
        "component4",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "",
        "toString",
        "sdk-server_release"
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
.field private device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

.field private imageBase64:Ljava/lang/String;

.field private personId:Ljava/lang/String;

.field private similarity:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V
    .locals 1
    .param p1, "imageBase64"    # Ljava/lang/String;
    .param p2, "similarity"    # Ljava/lang/String;
    .param p3, "personId"    # Ljava/lang/String;
    .param p4, "device_meta"    # Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    const-string v0, "imageBase64"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "similarity"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "device_meta"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    .line 12
    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    .line 13
    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    .line 14
    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    .line 9
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;ILjava/lang/Object;)Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;
    .locals 0

    and-int/lit8 p6, p5, 0x1

    if-eqz p6, :cond_0

    iget-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    :cond_0
    and-int/lit8 p6, p5, 0x2

    if-eqz p6, :cond_1

    iget-object p2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    :cond_1
    and-int/lit8 p6, p5, 0x4

    if-eqz p6, :cond_2

    iget-object p3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    :cond_2
    and-int/lit8 p5, p5, 0x8

    if-eqz p5, :cond_3

    iget-object p4, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    :cond_3
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;
    .locals 1

    const-string v0, "imageBase64"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "similarity"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "personId"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "device_meta"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;

    invoke-direct {v0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    iget-object v1, v1, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_5

    return v2

    :cond_5
    return v0
.end method

.method public final getDevice_meta()Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;
    .locals 1

    .line 14
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    return-object v0
.end method

.method public final getImageBase64()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    return-object v0
.end method

.method public final getPersonId()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSimilarity()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public final setDevice_meta(Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 14
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    return-void
.end method

.method public final setImageBase64(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    return-void
.end method

.method public final setPersonId(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    return-void
.end method

.method public final setSimilarity(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "OnlineRecognizeParam(imageBase64="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->imageBase64:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", similarity="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->similarity:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", personId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->personId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", device_meta="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/recog/online/param/OnlineRecognizeParam;->device_meta:Lcom/rokid/security/sdk/base/common/filesystem/DeviceMeta;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
