.class public final Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;
.super Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
.source "OwnerProfileClient.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Success"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0006\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\t\u0010\u0007\u001a\u00020\u0003H\u00c6\u0003J\u0013\u0010\u0008\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u0003H\u00c6\u0001J\u0013\u0010\t\u001a\u00020\n2\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u000cH\u00d6\u0003J\t\u0010\r\u001a\u00020\u000eH\u00d6\u0001J\t\u0010\u000f\u001a\u00020\u0010H\u00d6\u0001R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;",
        "Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;",
        "profile",
        "Lcom/rokid/security/sdk/ability/net/OwnerProfile;",
        "(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)V",
        "getProfile",
        "()Lcom/rokid/security/sdk/ability/net/OwnerProfile;",
        "component1",
        "copy",
        "equals",
        "",
        "other",
        "",
        "hashCode",
        "",
        "toString",
        "",
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
.field private final profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;


# direct methods
.method public constructor <init>(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)V
    .locals 1
    .param p1, "profile"    # Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    const-string v0, "profile"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 120
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;Lcom/rokid/security/sdk/ability/net/OwnerProfile;ILjava/lang/Object;)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;
    .locals 0

    and-int/lit8 p2, p2, 0x1

    if-eqz p2, :cond_0

    iget-object p1, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    :cond_0
    invoke-virtual {p0, p1}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->copy(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Lcom/rokid/security/sdk/ability/net/OwnerProfile;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    return-object v0
.end method

.method public final copy(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;
    .locals 1

    const-string v0, "profile"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    invoke-direct {v0, p1}, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;-><init>(Lcom/rokid/security/sdk/ability/net/OwnerProfile;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;

    iget-object v3, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    iget-object v1, v1, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    :cond_2
    return v0
.end method

.method public final getProfile()Lcom/rokid/security/sdk/ability/net/OwnerProfile;
    .locals 1

    .line 120
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    return-object v0
.end method

.method public hashCode()I
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    invoke-virtual {v0}, Lcom/rokid/security/sdk/ability/net/OwnerProfile;->hashCode()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Success(profile="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/ability/net/OwnerProfileFetchResult$Success;->profile:Lcom/rokid/security/sdk/ability/net/OwnerProfile;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
