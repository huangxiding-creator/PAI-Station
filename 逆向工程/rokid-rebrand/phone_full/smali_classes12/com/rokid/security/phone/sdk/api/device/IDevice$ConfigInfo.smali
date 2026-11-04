.class public final Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;
.super Ljava/lang/Object;
.source "IDevice.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/phone/sdk/api/device/IDevice;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ConfigInfo"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\r\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u001d\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u0012\u0006\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0002\u0010\u0008J\t\u0010\u000e\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000f\u001a\u00020\u0005H\u00c6\u0003J\t\u0010\u0010\u001a\u00020\u0007H\u00c6\u0003J\'\u0010\u0011\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u00052\u0008\u0008\u0002\u0010\u0006\u001a\u00020\u0007H\u00c6\u0001J\u0013\u0010\u0012\u001a\u00020\u00072\u0008\u0010\u0013\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0014\u001a\u00020\u0015H\u00d6\u0001J\t\u0010\u0016\u001a\u00020\u0005H\u00d6\u0001R\u0011\u0010\u0006\u001a\u00020\u0007\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0006\u0010\tR\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\r\u00a8\u0006\u0017"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;",
        "",
        "key",
        "Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;",
        "rename",
        "",
        "isHide",
        "",
        "(Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;Z)V",
        "()Z",
        "getKey",
        "()Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;",
        "getRename",
        "()Ljava/lang/String;",
        "component1",
        "component2",
        "component3",
        "copy",
        "equals",
        "other",
        "hashCode",
        "",
        "toString",
        "sdk-api_release"
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
.field private final isHide:Z

.field private final key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

.field private final rename:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;Z)V
    .locals 1
    .param p1, "key"    # Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .param p2, "rename"    # Ljava/lang/String;
    .param p3, "isHide"    # Z

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "rename"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    iput-boolean p3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;ZILjava/lang/Object;)Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;
    .locals 0

    and-int/lit8 p5, p4, 0x1

    if-eqz p5, :cond_0

    iget-object p1, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    :cond_0
    and-int/lit8 p5, p4, 0x2

    if-eqz p5, :cond_1

    iget-object p2, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    :cond_1
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_2

    iget-boolean p3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    :cond_2
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->copy(Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;Z)Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Z
    .locals 1

    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    return v0
.end method

.method public final copy(Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;Z)Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;
    .locals 1

    const-string v0, "key"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "rename"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;

    invoke-direct {v0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;-><init>(Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;Ljava/lang/String;Z)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    if-eq v3, v4, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-boolean v3, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    iget-boolean v1, v1, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    if-eq v3, v1, :cond_4

    return v2

    :cond_4
    return v0
.end method

.method public final getKey()Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    return-object v0
.end method

.method public final getRename()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    mul-int/lit8 v0, v1, 0x1f

    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    if-eqz v2, :cond_0

    const/4 v2, 0x1

    :cond_0
    add-int/2addr v0, v2

    return v0
.end method

.method public final isHide()Z
    .locals 1

    .line 43
    iget-boolean v0, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ConfigInfo(key="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->key:Lcom/rokid/security/phone/sdk/api/device/IDevice$DefaultGlassApp;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", rename="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->rename:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", isHide="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/rokid/security/phone/sdk/api/device/IDevice$ConfigInfo;->isHide:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
