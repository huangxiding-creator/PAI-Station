.class final Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;
.super Lkotlin/jvm/internal/Lambda;
.source "InspectionServiceImpl.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1;->uploadNonGlobalResources(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function3<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        "Ljava/lang/Long;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0016\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\t\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u0006H\n\u00a2\u0006\u0002\u0008\u0007"
    }
    d2 = {
        "<anonymous>",
        "",
        "data",
        "",
        "sessionId",
        "time",
        "",
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
.field final synthetic $fileId:Ljava/lang/String;

.field final synthetic $url:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->$url:Ljava/lang/String;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->$fileId:Ljava/lang/String;

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1, "p1"    # Ljava/lang/Object;
    .param p2, "p2"    # Ljava/lang/Object;
    .param p3, "p3"    # Ljava/lang/Object;

    .line 118
    move-object v0, p1

    check-cast v0, Ljava/lang/String;

    move-object v1, p2

    check-cast v1, Ljava/lang/String;

    move-object v2, p3

    check-cast v2, Ljava/lang/Number;

    invoke-virtual {v2}, Ljava/lang/Number;->longValue()J

    move-result-wide v2

    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->invoke(Ljava/lang/String;Ljava/lang/String;J)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Ljava/lang/String;Ljava/lang/String;J)V
    .locals 6
    .param p1, "data"    # Ljava/lang/String;
    .param p2, "sessionId"    # Ljava/lang/String;
    .param p3, "time"    # J

    const-string v0, "data"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "sessionId"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 121
    const-string v0, ""

    .line 122
    .local v0, "audioUrl":Ljava/lang/String;
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->$url:Ljava/lang/String;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const-string v4, "aac"

    const/4 v5, 0x0

    invoke-static {v1, v4, v5, v2, v3}, Lkotlin/text/StringsKt;->endsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 123
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->$url:Ljava/lang/String;

    .line 125
    :cond_0
    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;

    .line 128
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl$fileSystemUploadListener$1$uploadNonGlobalResources$1;->$fileId:Ljava/lang/String;

    .line 126
    nop

    .line 127
    nop

    .line 129
    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    .line 125
    invoke-direct {v1, v2, p1, v0, v3}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Long;)V

    .line 131
    .local v1, "photoItem":Lcom/rokid/security/phone/sdk/server/inspection/PhotoItem;
    new-instance v2, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;

    invoke-static {v1}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v3

    invoke-direct {v2, p2, v3}, Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;-><init>(Ljava/lang/String;Ljava/util/List;)V

    .line 132
    .local v2, "pr":Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;
    sget-object v3, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->INSTANCE:Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;

    invoke-virtual {v3, v2}, Lcom/rokid/security/phone/sdk/server/inspection/InspectRequest;->uploadPhoto(Lcom/rokid/security/phone/sdk/server/inspection/PhotoUploadRequest;)V

    .line 133
    return-void
.end method
