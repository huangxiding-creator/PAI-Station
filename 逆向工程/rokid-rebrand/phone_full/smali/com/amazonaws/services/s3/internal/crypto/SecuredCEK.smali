.class Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;
.super Ljava/lang/Object;
.source "SecuredCEK.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# instance fields
.field private final encrypted:[B

.field private final keyWrapAlgorithm:Ljava/lang/String;

.field private final matdesc:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method constructor <init>([BLjava/lang/String;Ljava/util/Map;)V
    .locals 1
    .param p1, "encryptedKey"    # [B
    .param p2, "keyWrapAlgorithm"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([B",
            "Ljava/lang/String;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 47
    .local p3, "matdesc":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/String;Ljava/lang/String;>;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->encrypted:[B

    .line 49
    iput-object p2, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->keyWrapAlgorithm:Ljava/lang/String;

    .line 50
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0, p3}, Ljava/util/TreeMap;-><init>(Ljava/util/Map;)V

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableMap(Ljava/util/Map;)Ljava/util/Map;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->matdesc:Ljava/util/Map;

    .line 51
    return-void
.end method


# virtual methods
.method getEncrypted()[B
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->encrypted:[B

    return-object v0
.end method

.method getKeyWrapAlgorithm()Ljava/lang/String;
    .locals 1

    .line 58
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->keyWrapAlgorithm:Ljava/lang/String;

    return-object v0
.end method

.method getMaterialDescription()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 65
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/SecuredCEK;->matdesc:Ljava/util/Map;

    return-object v0
.end method
