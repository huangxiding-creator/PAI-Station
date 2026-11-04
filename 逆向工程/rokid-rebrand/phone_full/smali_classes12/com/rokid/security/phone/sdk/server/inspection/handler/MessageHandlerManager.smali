.class public final Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;
.super Ljava/lang/Object;
.source "MessageHandlerManager.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nMessageHandlerManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 MessageHandlerManager.kt\ncom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,61:1\n1360#2:62\n1446#2,5:63\n*S KotlinDebug\n*F\n+ 1 MessageHandlerManager.kt\ncom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager\n*L\n59#1:62\n59#1:63,5\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0018\u0000 \u00112\u00020\u0001:\u0001\u0011B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004J\u000c\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u00020\n0\tJ\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u000eJ\u0008\u0010\u000f\u001a\u00020\u0010H\u0002R\u0014\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;",
        "",
        "serviceImpl",
        "Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;",
        "(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V",
        "handlers",
        "",
        "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
        "getAllSupportedMethods",
        "",
        "",
        "handleMessage",
        "",
        "aiChatExtra",
        "Lcom/rokid/security/sdk/base/common/AiChatExtra;",
        "registerHandlers",
        "",
        "Companion",
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


# static fields
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager$Companion;

.field private static final TAG:Ljava/lang/String; = "MessageHandlerManager"


# instance fields
.field private final handlers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;",
            ">;"
        }
    .end annotation
.end field

.field private final serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->Companion:Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager$Companion;

    return-void
.end method

.method public constructor <init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V
    .locals 1
    .param p1, "serviceImpl"    # Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    const-string/jumbo v0, "serviceImpl"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    .line 18
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    .line 20
    nop

    .line 22
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->registerHandlers()V

    .line 23
    nop

    .line 12
    return-void
.end method

.method private final registerHandlers()V
    .locals 3

    .line 29
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/handler/InspectHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 30
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/handler/SessionHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 31
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->serviceImpl:Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/inspection/handler/RecordHandler;-><init>(Lcom/rokid/security/phone/sdk/server/inspection/InspectionServiceImpl;)V

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 32
    return-void
.end method


# virtual methods
.method public final getAllSupportedMethods()Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 59
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$flatMap$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 62
    .local v1, "$i$f$flatMap":I
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    check-cast v2, Ljava/util/Collection;

    .local v2, "destination$iv$iv":Ljava/util/Collection;
    move-object v3, v0

    .local v3, "$this$flatMapTo$iv$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 63
    .local v4, "$i$f$flatMapTo":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_0

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .line 64
    .local v6, "element$iv$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;

    .local v7, "it":Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
    const/4 v8, 0x0

    .line 59
    .local v8, "$i$a$-flatMap-MessageHandlerManager$getAllSupportedMethods$1":I
    invoke-virtual {v7}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->getSupportedMethods()Ljava/util/List;

    move-result-object v7

    .line 64
    .end local v7    # "it":Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
    .end local v8    # "$i$a$-flatMap-MessageHandlerManager$getAllSupportedMethods$1":I
    check-cast v7, Ljava/lang/Iterable;

    .line 65
    .local v7, "list$iv$iv":Ljava/lang/Iterable;
    invoke-static {v2, v7}, Lkotlin/collections/CollectionsKt;->addAll(Ljava/util/Collection;Ljava/lang/Iterable;)Z

    goto :goto_0

    .line 67
    .end local v6    # "element$iv$iv":Ljava/lang/Object;
    .end local v7    # "list$iv$iv":Ljava/lang/Iterable;
    :cond_0
    nop

    .end local v2    # "destination$iv$iv":Ljava/util/Collection;
    .end local v3    # "$this$flatMapTo$iv$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$flatMapTo":I
    check-cast v2, Ljava/util/List;

    .line 62
    nop

    .end local v0    # "$this$flatMap$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$flatMap":I
    check-cast v2, Ljava/lang/Iterable;

    .line 59
    invoke-static {v2}, Lkotlin/collections/CollectionsKt;->distinct(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public final handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)Z
    .locals 5
    .param p1, "aiChatExtra"    # Lcom/rokid/security/sdk/base/common/AiChatExtra;

    const-string v0, "aiChatExtra"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/AiChatExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    .line 40
    .local v0, "methodName":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "handleMessage \u5904\u7406\u65b9\u6cd5: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    const-string v2, "MessageHandlerManager"

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 42
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandlerManager;->handlers:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;

    .line 43
    .local v3, "handler":Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
    invoke-virtual {v3}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->getSupportedMethods()Ljava/util/List;

    move-result-object v4

    invoke-interface {v4, v0}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 44
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v4, "\u627e\u5230\u5904\u7406\u5668: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v4

    invoke-static {v4}, Lkotlin/jvm/internal/Reflection;->getOrCreateKotlinClass(Ljava/lang/Class;)Lkotlin/reflect/KClass;

    move-result-object v4

    invoke-interface {v4}, Lkotlin/reflect/KClass;->getSimpleName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v4, " \u5904\u7406\u65b9\u6cd5: "

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    invoke-virtual {v3, p1}, Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;->handleMessage(Lcom/rokid/security/sdk/base/common/AiChatExtra;)V

    .line 46
    const/4 v1, 0x1

    return v1

    .line 50
    .end local v3    # "handler":Lcom/rokid/security/phone/sdk/server/inspection/handler/MessageHandler;
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "\u672a\u627e\u5230\u5904\u7406\u5668\u5904\u7406\u65b9\u6cd5: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v2, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->w(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 51
    const/4 v1, 0x0

    return v1
.end method
