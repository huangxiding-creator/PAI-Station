.class public final Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;
.super Ljava/lang/Object;
.source "UserTokenFailureEvents.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nUserTokenFailureEvents.kt\nKotlin\n*S Kotlin\n*F\n+ 1 UserTokenFailureEvents.kt\ncom/rokid/security/sdk/ability/auth/UserTokenFailureEvents\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,123:1\n1#2:124\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00008\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0018\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001)B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J$\u0010\u0015\u001a\u00020\u00102\u0006\u0010\u0016\u001a\u00020\u000f2\u0012\u0010\u0017\u001a\u000e\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u00100\u000eH\u0002J\u001c\u0010\u0018\u001a\u00020\u00102\u0012\u0010\u0019\u001a\u000e\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u00100\u000eH\u0002J\u000e\u0010\u001a\u001a\u00020\u00062\u0006\u0010\u001b\u001a\u00020\u0006J\u0010\u0010\u001c\u001a\u00020\u00122\u0006\u0010\u001a\u001a\u00020\u0006H\u0002J\u0010\u0010\u001d\u001a\u00020\u00062\u0006\u0010\u001e\u001a\u00020\u0006H\u0002J \u0010\u001f\u001a\u00020\u00102\u0006\u0010 \u001a\u00020\u00062\u0006\u0010!\u001a\u00020\u00062\u0008\u0008\u0002\u0010\"\u001a\u00020\u0012J\u001e\u0010#\u001a\u00020\u00122\u0006\u0010 \u001a\u00020\u00062\u0006\u0010$\u001a\u00020\u00062\u0006\u0010!\u001a\u00020\u0006J\u000e\u0010%\u001a\u00020\u00102\u0006\u0010\u001b\u001a\u00020\u0006J\u001c\u0010&\u001a\u00020\u00102\u0014\u0010\u001e\u001a\u0010\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u0010\u0018\u00010\u000eJ#\u0010\'\u001a\u00020\u00102\u0014\u0010\u001e\u001a\u0010\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u0012\u0018\u00010\u000eH\u0000\u00a2\u0006\u0002\u0008(R\u000e\u0010\u0003\u001a\u00020\u0004X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0006X\u0086T\u00a2\u0006\u0002\n\u0000R\u001c\u0010\n\u001a\u0010\u0012\u000c\u0012\n \u000c*\u0004\u0018\u00010\u00060\u00060\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\"\u0010\r\u001a\u0016\u0012\u0012\u0012\u0010\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u0010\u0018\u00010\u000e0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R4\u0010\u0011\u001a(\u0012$\u0012\"\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u0012 \u000c*\u0010\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u0012\u0018\u00010\u000e0\u000e0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0016\u0010\u0013\u001a\n\u0012\u0006\u0012\u0004\u0018\u00010\u000f0\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0014\u001a\u000e\u0012\u0004\u0012\u00020\u0006\u0012\u0004\u0012\u00020\u00120\u000eX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006*"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;",
        "",
        "()V",
        "FAILURE_CODE",
        "",
        "RELAY_ACTION",
        "",
        "RELAY_TOKEN_FINGERPRINT",
        "SYSTEM_SERVER_PACKAGE",
        "SYSTEM_SERVER_RECEIVER",
        "lastNotifiedFingerprint",
        "Ljava/util/concurrent/atomic/AtomicReference;",
        "kotlin.jvm.PlatformType",
        "listener",
        "Lkotlin/Function1;",
        "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
        "",
        "localInvalidator",
        "",
        "pendingEvent",
        "productionLocalInvalidator",
        "deliverIfNew",
        "event",
        "target",
        "deliverPending",
        "installedListener",
        "fingerprint",
        "userToken",
        "markFingerprintForDelivery",
        "normalizeBearerToken",
        "value",
        "notify",
        "expectedUserToken",
        "source",
        "localStateAlreadyInvalidated",
        "notifyIfTerminalResponse",
        "responseBody",
        "onUserTokenChanged",
        "setListener",
        "setLocalInvalidatorForTest",
        "setLocalInvalidatorForTest$sdk_common_ability_release",
        "Event",
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


# static fields
.field public static final FAILURE_CODE:I = 0xc389

.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

.field public static final RELAY_ACTION:Ljava/lang/String; = "com.rokid.security.system.action.USER_TOKEN_FAILURE"

.field public static final RELAY_TOKEN_FINGERPRINT:Ljava/lang/String; = "token_fingerprint"

.field public static final SYSTEM_SERVER_PACKAGE:Ljava/lang/String; = "com.rokid.security.system.server"

.field public static final SYSTEM_SERVER_RECEIVER:Ljava/lang/String; = "com.rokid.security.system.server.business.account.UserTokenFailureReceiver"

.field private static final lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/atomic/AtomicReference<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final listener:Ljava/util/concurrent/atomic/AtomicReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/atomic/AtomicReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            "Lkotlin/Unit;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final localInvalidator:Ljava/util/concurrent/atomic/AtomicReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/atomic/AtomicReference<",
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;>;"
        }
    .end annotation
.end field

.field private static final pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/atomic/AtomicReference<",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            ">;"
        }
    .end annotation
.end field

.field private static final productionLocalInvalidator:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$CPQBfhkzCKHzszoS3j8Cmikho9E(Ljava/lang/String;Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;)Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->onUserTokenChanged$lambda$1(Ljava/lang/String;Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;)Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;

    move-result-object p0

    return-object p0
.end method

.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    .line 21
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->listener:Ljava/util/concurrent/atomic/AtomicReference;

    .line 27
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;

    .line 28
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    const-string v1, ""

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;

    .line 30
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$productionLocalInvalidator$1;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$productionLocalInvalidator$1;

    check-cast v0, Lkotlin/jvm/functions/Function1;

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->productionLocalInvalidator:Lkotlin/jvm/functions/Function1;

    .line 31
    new-instance v0, Ljava/util/concurrent/atomic/AtomicReference;

    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->productionLocalInvalidator:Lkotlin/jvm/functions/Function1;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;-><init>(Ljava/lang/Object;)V

    sput-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->localInvalidator:Ljava/util/concurrent/atomic/AtomicReference;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final deliverIfNew(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "event"    # Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    .param p2, "target"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 95
    invoke-virtual {p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;->getExpectedUserToken()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 96
    .local v0, "fingerprint":Ljava/lang/String;
    invoke-direct {p0, v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->markFingerprintForDelivery(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    return-void

    .line 97
    :cond_0
    invoke-interface {p2, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 98
    return-void
.end method

.method private final deliverPending(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "installedListener"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 88
    nop

    :goto_0
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->listener:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    if-ne v0, p1, :cond_1

    .line 89
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;->getAndSet(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;

    if-nez v0, :cond_0

    return-void

    .line 90
    .local v0, "event":Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    :cond_0
    invoke-direct {p0, v0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->deliverIfNew(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;Lkotlin/jvm/functions/Function1;)V

    .end local v0    # "event":Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    goto :goto_0

    .line 92
    :cond_1
    return-void
.end method

.method private final markFingerprintForDelivery(Ljava/lang/String;)Z
    .locals 2
    .param p1, "fingerprint"    # Ljava/lang/String;

    .line 101
    nop

    :cond_0
    nop

    .line 102
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 103
    .local v0, "previous":Ljava/lang/String;
    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    const/4 v1, 0x0

    return v1

    .line 104
    :cond_1
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-static {v1, v0, p1}, Landroidx/lifecycle/LifecycleKt$$ExternalSyntheticBackportWithForwarding0;->m(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    return v1
.end method

.method private final normalizeBearerToken(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "value"    # Ljava/lang/String;

    .line 121
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "Bearer "

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "bearer "

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1}, Lkotlin/text/StringsKt;->removePrefix(Ljava/lang/String;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->trim(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static synthetic notify$default(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)V
    .locals 0

    .line 38
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    .line 41
    const/4 p3, 0x0

    .line 38
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->notify(Ljava/lang/String;Ljava/lang/String;Z)V

    return-void
.end method

.method private static final onUserTokenChanged$lambda$1(Ljava/lang/String;Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;)Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    .locals 5
    .param p0, "$currentFingerprint"    # Ljava/lang/String;
    .param p1, "pending"    # Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;

    const-string v0, "$currentFingerprint"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 78
    const/4 v0, 0x0

    if-eqz p1, :cond_0

    move-object v1, p1

    .line 124
    .local v1, "it":Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    const/4 v2, 0x0

    .line 78
    .local v2, "$i$a$-takeIf-UserTokenFailureEvents$onUserTokenChanged$1$1":I
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;->getExpectedUserToken()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3, p0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    .end local v1    # "it":Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    .end local v2    # "$i$a$-takeIf-UserTokenFailureEvents$onUserTokenChanged$1$1":I
    if-eqz v1, :cond_0

    move-object v0, p1

    :cond_0
    return-object v0
.end method


# virtual methods
.method public final fingerprint(Ljava/lang/String;)Ljava/lang/String;
    .locals 14
    .param p1, "userToken"    # Ljava/lang/String;

    const-string/jumbo v0, "userToken"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 109
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->normalizeBearerToken(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 110
    .local v0, "normalized":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    const-string v2, ""

    if-eqz v1, :cond_0

    return-object v2

    .line 111
    :cond_0
    const-string v1, "SHA-256"

    invoke-static {v1}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v1

    .line 112
    sget-object v3, Lkotlin/text/Charsets;->UTF_8:Ljava/nio/charset/Charset;

    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v3

    const-string/jumbo v4, "this as java.lang.String).getBytes(charset)"

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1, v3}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v5

    const-string v1, "getInstance(\"SHA-256\")\n \u2026yteArray(Charsets.UTF_8))"

    invoke-static {v5, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 113
    move-object v6, v2

    check-cast v6, Ljava/lang/CharSequence;

    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$fingerprint$1;->INSTANCE:Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$fingerprint$1;

    move-object v11, v1

    check-cast v11, Lkotlin/jvm/functions/Function1;

    const/16 v12, 0x1e

    const/4 v13, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-static/range {v5 .. v13}, Lkotlin/collections/ArraysKt;->joinToString$default([BLjava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 111
    return-object v1
.end method

.method public final notify(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 6
    .param p1, "expectedUserToken"    # Ljava/lang/String;
    .param p2, "source"    # Ljava/lang/String;
    .param p3, "localStateAlreadyInvalidated"    # Z

    const-string v0, "expectedUserToken"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "source"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->normalizeBearerToken(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 44
    .local v0, "normalized":Ljava/lang/String;
    move-object v1, v0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    .line 45
    :cond_0
    if-nez p3, :cond_1

    .line 46
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->localInvalidator:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lkotlin/jvm/functions/Function1;

    invoke-interface {v1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 48
    :cond_1
    new-instance v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;

    invoke-direct {v1, v0, p2}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 49
    .local v1, "event":Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->listener:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lkotlin/jvm/functions/Function1;

    .line 50
    .local v2, "currentListener":Lkotlin/jvm/functions/Function1;
    if-eqz v2, :cond_2

    .line 51
    invoke-direct {p0, v1, v2}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->deliverIfNew(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;Lkotlin/jvm/functions/Function1;)V

    .line 52
    return-void

    .line 55
    :cond_2
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v3, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 58
    sget-object v3, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->listener:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lkotlin/jvm/functions/Function1;

    if-nez v3, :cond_3

    return-void

    .line 59
    .local v3, "installedListener":Lkotlin/jvm/functions/Function1;
    :cond_3
    sget-object v4, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;

    const/4 v5, 0x0

    invoke-static {v4, v1, v5}, Landroidx/lifecycle/LifecycleKt$$ExternalSyntheticBackportWithForwarding0;->m(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 60
    invoke-direct {p0, v1, v3}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->deliverIfNew(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;Lkotlin/jvm/functions/Function1;)V

    .line 62
    :cond_4
    return-void
.end method

.method public final notifyIfTerminalResponse(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Z
    .locals 7
    .param p1, "expectedUserToken"    # Ljava/lang/String;
    .param p2, "responseBody"    # Ljava/lang/String;
    .param p3, "source"    # Ljava/lang/String;

    const-string v0, "expectedUserToken"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "responseBody"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "source"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 69
    sget-object v0, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->INSTANCE:Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;

    invoke-virtual {v0, p2}, Lcom/rokid/security/sdk/ability/net/TopLevelResponseCodeParser;->parse(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v0

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    const v1, 0xc389

    if-eq v0, v1, :cond_1

    :goto_0
    const/4 v0, 0x0

    return v0

    .line 70
    :cond_1
    const/4 v5, 0x4

    const/4 v6, 0x0

    const/4 v4, 0x0

    move-object v1, p0

    move-object v2, p1

    move-object v3, p3

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->notify$default(Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)V

    .line 71
    const/4 v0, 0x1

    return v0
.end method

.method public final onUserTokenChanged(Ljava/lang/String;)V
    .locals 4
    .param p1, "userToken"    # Ljava/lang/String;

    const-string/jumbo v0, "userToken"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 76
    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->normalizeBearerToken(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->fingerprint(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 77
    .local v0, "currentFingerprint":Ljava/lang/String;
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->pendingEvent:Ljava/util/concurrent/atomic/AtomicReference;

    new-instance v2, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$$ExternalSyntheticLambda0;

    invoke-direct {v2, v0}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$$ExternalSyntheticLambda0;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, v2}, Ljava/util/concurrent/atomic/AtomicReference;->updateAndGet(Ljava/util/function/UnaryOperator;)Ljava/lang/Object;

    .line 80
    :cond_0
    nop

    .line 81
    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 82
    .local v1, "previous":Ljava/lang/String;
    const-string v2, "previous"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v2, v1

    check-cast v2, Ljava/lang/CharSequence;

    invoke-interface {v2}, Ljava/lang/CharSequence;->length()I

    move-result v2

    if-nez v2, :cond_1

    const/4 v2, 0x1

    goto :goto_0

    :cond_1
    const/4 v2, 0x0

    :goto_0
    if-nez v2, :cond_3

    invoke-static {v1, v0}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_1

    .line 83
    :cond_2
    sget-object v2, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->lastNotifiedFingerprint:Ljava/util/concurrent/atomic/AtomicReference;

    const-string v3, ""

    invoke-static {v2, v1, v3}, Landroidx/lifecycle/LifecycleKt$$ExternalSyntheticBackportWithForwarding0;->m(Ljava/util/concurrent/atomic/AtomicReference;Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-void

    .line 82
    :cond_3
    :goto_1
    return-void
.end method

.method public final setListener(Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "value"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents$Event;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .line 34
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->listener:Ljava/util/concurrent/atomic/AtomicReference;

    invoke-virtual {v0, p1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 35
    if-eqz p1, :cond_0

    invoke-direct {p0, p1}, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->deliverPending(Lkotlin/jvm/functions/Function1;)V

    .line 36
    :cond_0
    return-void
.end method

.method public final setLocalInvalidatorForTest$sdk_common_ability_release(Lkotlin/jvm/functions/Function1;)V
    .locals 2
    .param p1, "value"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Ljava/lang/Boolean;",
            ">;)V"
        }
    .end annotation

    .line 117
    sget-object v0, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->localInvalidator:Ljava/util/concurrent/atomic/AtomicReference;

    if-nez p1, :cond_0

    sget-object v1, Lcom/rokid/security/sdk/ability/auth/UserTokenFailureEvents;->productionLocalInvalidator:Lkotlin/jvm/functions/Function1;

    goto :goto_0

    :cond_0
    move-object v1, p1

    :goto_0
    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicReference;->set(Ljava/lang/Object;)V

    .line 118
    return-void
.end method
