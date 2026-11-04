.class public final Lcom/rokid/security/phone/sdk/server/feature/repository/BusinessRepository;
.super Ljava/lang/Object;
.source "BusinessRepository.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0014\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/feature/repository/BusinessRepository;",
        "",
        "()V",
        "mGson",
        "Lcom/google/gson/Gson;",
        "getMGson",
        "()Lcom/google/gson/Gson;",
        "setMGson",
        "(Lcom/google/gson/Gson;)V",
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
.field private mGson:Lcom/google/gson/Gson;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    new-instance v0, Lcom/google/gson/Gson;

    invoke-direct {v0}, Lcom/google/gson/Gson;-><init>()V

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/feature/repository/BusinessRepository;->mGson:Lcom/google/gson/Gson;

    .line 8
    return-void
.end method


# virtual methods
.method public final getMGson()Lcom/google/gson/Gson;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/feature/repository/BusinessRepository;->mGson:Lcom/google/gson/Gson;

    return-object v0
.end method

.method public final setMGson(Lcom/google/gson/Gson;)V
    .locals 1
    .param p1, "<set-?>"    # Lcom/google/gson/Gson;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/feature/repository/BusinessRepository;->mGson:Lcom/google/gson/Gson;

    return-void
.end method
