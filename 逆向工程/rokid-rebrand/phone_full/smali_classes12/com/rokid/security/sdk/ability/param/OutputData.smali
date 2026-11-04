.class public final Lcom/rokid/security/sdk/ability/param/OutputData;
.super Ljava/lang/Object;
.source "AsrIntent.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\t\u0010\u000b\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000c\u001a\u00020\u0005H\u00c6\u0003J\u001d\u0010\r\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005H\u00c6\u0001J\u0013\u0010\u000e\u001a\u00020\u000f2\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0011\u001a\u00020\u0012H\u00d6\u0001J\t\u0010\u0013\u001a\u00020\u0003H\u00d6\u0001R\u0016\u0010\u0002\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008R\u0016\u0010\u0004\u001a\u00020\u00058\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/param/OutputData;",
        "",
        "command",
        "",
        "params",
        "Lcom/rokid/security/sdk/ability/param/OutputParams;",
        "(Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;)V",
        "getCommand",
        "()Ljava/lang/String;",
        "getParams",
        "()Lcom/rokid/security/sdk/ability/param/OutputParams;",
        "component1",
        "component2",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "",
        "toString",
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
.field private final command:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "command"
    .end annotation
.end field

.field private final params:Lcom/rokid/security/sdk/ability/param/OutputParams;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "params"
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;)V
    .locals 1
    .param p1, "command"    # Ljava/lang/String;
    .param p2, "params"    # Lcom/rokid/security/sdk/ability/param/OutputParams;

    const-string v0, "command"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "params"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    iput-object p1, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    .line 40
    iput-object p2, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    .line 38
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/param/OutputData;Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/param/OutputData;
    .locals 0

    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    iget-object p1, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    iget-object p2, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/sdk/ability/param/OutputData;->copy(Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;)Lcom/rokid/security/sdk/ability/param/OutputData;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Lcom/rokid/security/sdk/ability/param/OutputParams;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;)Lcom/rokid/security/sdk/ability/param/OutputData;
    .locals 1

    const-string v0, "command"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "params"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/ability/param/OutputData;

    invoke-direct {v0, p1, p2}, Lcom/rokid/security/sdk/ability/param/OutputData;-><init>(Ljava/lang/String;Lcom/rokid/security/sdk/ability/param/OutputParams;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/param/OutputData;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/param/OutputData;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return v2

    :cond_3
    return v0
.end method

.method public final getCommand()Ljava/lang/String;
    .locals 1

    .line 39
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    return-object v0
.end method

.method public final getParams()Lcom/rokid/security/sdk/ability/param/OutputParams;
    .locals 1

    .line 40
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget-object v2, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    invoke-virtual {v2}, Lcom/rokid/security/sdk/ability/param/OutputParams;->hashCode()I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "OutputData(command="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->command:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", params="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/param/OutputData;->params:Lcom/rokid/security/sdk/ability/param/OutputParams;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
