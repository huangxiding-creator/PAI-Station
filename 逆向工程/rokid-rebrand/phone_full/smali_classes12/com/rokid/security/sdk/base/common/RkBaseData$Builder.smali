.class public final Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
.super Ljava/lang/Object;
.source "RkBaseData.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/base/common/RkBaseData;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRkBaseData.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RkBaseData.kt\ncom/rokid/security/sdk/base/common/RkBaseData$Builder\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,79:1\n1#2:80\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\t\u001a\u00020\nJ\u000e\u0010\u000b\u001a\u00020\u00002\u0006\u0010\u000c\u001a\u00020\u0004J\u000e\u0010\r\u001a\u00020\u00002\u0006\u0010\u0005\u001a\u00020\u0004J\u000e\u0010\u000e\u001a\u00020\u00002\u0006\u0010\u000c\u001a\u00020\u0004J\u000e\u0010\u000f\u001a\u00020\u00002\u0006\u0010\u000c\u001a\u00020\u0004J\u000e\u0010\u0010\u001a\u00020\u00002\u0006\u0010\u0008\u001a\u00020\u0004R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;",
        "",
        "()V",
        "clientId",
        "",
        "extra",
        "requestId",
        "responseId",
        "type",
        "build",
        "Lcom/rokid/security/sdk/base/common/RkBaseData;",
        "setClientId",
        "id",
        "setExtra",
        "setRequestId",
        "setResponseId",
        "setType",
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
.field private clientId:Ljava/lang/String;

.field private extra:Ljava/lang/String;

.field private requestId:Ljava/lang/String;

.field private responseId:Ljava/lang/String;

.field private type:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 58
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->type:Ljava/lang/String;

    .line 59
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->extra:Ljava/lang/String;

    .line 60
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->requestId:Ljava/lang/String;

    .line 61
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->responseId:Ljava/lang/String;

    .line 62
    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->clientId:Ljava/lang/String;

    .line 56
    return-void
.end method


# virtual methods
.method public final build()Lcom/rokid/security/sdk/base/common/RkBaseData;
    .locals 10

    .line 76
    new-instance v9, Lcom/rokid/security/sdk/base/common/RkBaseData;

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->type:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->extra:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->requestId:Ljava/lang/String;

    iget-object v4, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->responseId:Ljava/lang/String;

    iget-object v5, p0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->clientId:Ljava/lang/String;

    const/16 v7, 0x20

    const/4 v8, 0x0

    const/4 v6, 0x0

    move-object v0, v9

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/sdk/base/common/RkBaseData;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object v9
.end method

.method public final setClientId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .locals 2
    .param p1, "id"    # Ljava/lang/String;

    const-string v0, "id"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 73
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    .line 80
    .local v0, "$this$setClientId_u24lambda_u244":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    const/4 v1, 0x0

    .line 73
    .local v1, "$i$a$-apply-RkBaseData$Builder$setClientId$1":I
    iput-object p1, v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->clientId:Ljava/lang/String;

    .end local v0    # "$this$setClientId_u24lambda_u244":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .end local v1    # "$i$a$-apply-RkBaseData$Builder$setClientId$1":I
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    return-object v0
.end method

.method public final setExtra(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .locals 2
    .param p1, "extra"    # Ljava/lang/String;

    const-string v0, "extra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 67
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    .line 80
    .local v0, "$this$setExtra_u24lambda_u241":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    const/4 v1, 0x0

    .line 67
    .local v1, "$i$a$-apply-RkBaseData$Builder$setExtra$1":I
    iput-object p1, v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->extra:Ljava/lang/String;

    .end local v0    # "$this$setExtra_u24lambda_u241":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .end local v1    # "$i$a$-apply-RkBaseData$Builder$setExtra$1":I
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    return-object v0
.end method

.method public final setRequestId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .locals 2
    .param p1, "id"    # Ljava/lang/String;

    const-string v0, "id"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    .line 80
    .local v0, "$this$setRequestId_u24lambda_u242":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    const/4 v1, 0x0

    .line 69
    .local v1, "$i$a$-apply-RkBaseData$Builder$setRequestId$1":I
    iput-object p1, v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->requestId:Ljava/lang/String;

    .end local v0    # "$this$setRequestId_u24lambda_u242":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .end local v1    # "$i$a$-apply-RkBaseData$Builder$setRequestId$1":I
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    return-object v0
.end method

.method public final setResponseId(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .locals 2
    .param p1, "id"    # Ljava/lang/String;

    const-string v0, "id"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 71
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    .line 80
    .local v0, "$this$setResponseId_u24lambda_u243":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    const/4 v1, 0x0

    .line 71
    .local v1, "$i$a$-apply-RkBaseData$Builder$setResponseId$1":I
    iput-object p1, v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->responseId:Ljava/lang/String;

    .end local v0    # "$this$setResponseId_u24lambda_u243":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .end local v1    # "$i$a$-apply-RkBaseData$Builder$setResponseId$1":I
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    return-object v0
.end method

.method public final setType(Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .locals 2
    .param p1, "type"    # Ljava/lang/String;

    const-string/jumbo v0, "type"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 65
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    .line 80
    .local v0, "$this$setType_u24lambda_u240":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    const/4 v1, 0x0

    .line 65
    .local v1, "$i$a$-apply-RkBaseData$Builder$setType$1":I
    iput-object p1, v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;->type:Ljava/lang/String;

    .end local v0    # "$this$setType_u24lambda_u240":Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;
    .end local v1    # "$i$a$-apply-RkBaseData$Builder$setType$1":I
    move-object v0, p0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData$Builder;

    return-object v0
.end method
