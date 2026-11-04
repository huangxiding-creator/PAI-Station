.class final Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;
.super Lkotlin/jvm/internal/Lambda;
.source "RetrofitClient.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/sdk/ability/net/RetrofitClient;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lokhttp3/OkHttpClient;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
        "Lokhttp3/OkHttpClient;",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/security/sdk/ability/net/RetrofitClient;


# direct methods
.method constructor <init>(Lcom/rokid/security/sdk/ability/net/RetrofitClient;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;->this$0:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 58
    invoke-virtual {p0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;->invoke()Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method

.method public final invoke()Lokhttp3/OkHttpClient;
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/rokid/security/sdk/ability/net/RetrofitClient$okHttpClient$2;->this$0:Lcom/rokid/security/sdk/ability/net/RetrofitClient;

    invoke-static {v0}, Lcom/rokid/security/sdk/ability/net/RetrofitClient;->access$getClient(Lcom/rokid/security/sdk/ability/net/RetrofitClient;)Lokhttp3/OkHttpClient;

    move-result-object v0

    return-object v0
.end method
