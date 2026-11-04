.class final Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;
.super Ljava/util/LinkedHashMap;
.source "UriCanonicalizer.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/util/UriCanonicalizer;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "BoundedHashMap"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/util/LinkedHashMap<",
        "Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# static fields
.field private static final DEFAULT_SIZE:I = 0x40

.field private static final MAX_SIZE:I = 0x2cc


# direct methods
.method public constructor <init>()V
    .locals 3

    .line 70
    const v0, 0x3f333333    # 0.7f

    const/4 v1, 0x1

    const/16 v2, 0x40

    invoke-direct {p0, v2, v0, v1}, Ljava/util/LinkedHashMap;-><init>(IFZ)V

    .line 71
    return-void
.end method


# virtual methods
.method public removeEldestEntry(Ljava/util/Map$Entry;)Z
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map$Entry<",
            "Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    .line 76
    .local p1, "entry":Ljava/util/Map$Entry;, "Ljava/util/Map$Entry<Lcom/fasterxml/aalto/util/UriCanonicalizer$CanonicalKey;Ljava/lang/String;>;"
    invoke-virtual {p0}, Lcom/fasterxml/aalto/util/UriCanonicalizer$BoundedHashMap;->size()I

    move-result v0

    const/16 v1, 0x2cc

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
