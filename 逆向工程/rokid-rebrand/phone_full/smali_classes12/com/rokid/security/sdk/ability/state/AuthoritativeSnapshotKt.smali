.class public final Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshotKt;
.super Ljava/lang/Object;
.source "AuthoritativeSnapshot.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAuthoritativeSnapshot.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AuthoritativeSnapshot.kt\ncom/rokid/security/sdk/ability/state/AuthoritativeSnapshotKt\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,12:1\n1#2:13\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u001aC\u0010\u0000\u001a\n\u0012\u0004\u0012\u0002H\u0002\u0018\u00010\u0001\"\u0008\u0008\u0000\u0010\u0003*\u00020\u0004\"\u0004\u0008\u0001\u0010\u00022\u0008\u0010\u0005\u001a\u0004\u0018\u0001H\u00032\u0014\u0010\u0006\u001a\u0010\u0012\u0004\u0012\u0002H\u0003\u0012\u0006\u0012\u0004\u0018\u0001H\u00020\u0007\u00a2\u0006\u0002\u0010\u0008\u00a8\u0006\t"
    }
    d2 = {
        "authoritativeSnapshot",
        "Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot;",
        "T",
        "S",
        "",
        "source",
        "read",
        "Lkotlin/Function1;",
        "(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot;",
        "sdk-common-ability_release"
    }
    k = 0x2
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static final authoritativeSnapshot(Ljava/lang/Object;Lkotlin/jvm/functions/Function1;)Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot;
    .locals 4
    .param p0, "source"    # Ljava/lang/Object;
    .param p1, "read"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<S:",
            "Ljava/lang/Object;",
            "T:",
            "Ljava/lang/Object;",
            ">(TS;",
            "Lkotlin/jvm/functions/Function1<",
            "-TS;+TT;>;)",
            "Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot<",
            "TT;>;"
        }
    .end annotation

    const-string v0, "read"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    if-eqz p0, :cond_0

    move-object v0, p0

    .line 13
    .local v0, "it":Ljava/lang/Object;
    const/4 v1, 0x0

    .line 11
    .local v1, "$i$a$-let-AuthoritativeSnapshotKt$authoritativeSnapshot$1":I
    new-instance v2, Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot;

    invoke-interface {p1, v0}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/rokid/security/sdk/ability/state/AuthoritativeSnapshot;-><init>(Ljava/lang/Object;)V

    .end local v0    # "it":Ljava/lang/Object;
    .end local v1    # "$i$a$-let-AuthoritativeSnapshotKt$authoritativeSnapshot$1":I
    goto :goto_0

    :cond_0
    const/4 v2, 0x0

    :goto_0
    return-object v2
.end method
