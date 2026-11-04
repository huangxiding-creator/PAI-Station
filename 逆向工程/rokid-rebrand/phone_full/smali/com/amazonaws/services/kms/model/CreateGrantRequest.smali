.class public Lcom/amazonaws/services/kms/model/CreateGrantRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "CreateGrantRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private constraints:Lcom/amazonaws/services/kms/model/GrantConstraints;

.field private grantTokens:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private granteePrincipal:Ljava/lang/String;

.field private keyId:Ljava/lang/String;

.field private name:Ljava/lang/String;

.field private operations:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private retiringPrincipal:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 136
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 223
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    .line 256
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 5
    .param p1, "obj"    # Ljava/lang/Object;

    .line 1284
    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    .line 1285
    return v0

    .line 1286
    :cond_0
    const/4 v1, 0x0

    if-nez p1, :cond_1

    .line 1287
    return v1

    .line 1289
    :cond_1
    instance-of v2, p1, Lcom/amazonaws/services/kms/model/CreateGrantRequest;

    if-nez v2, :cond_2

    .line 1290
    return v1

    .line 1291
    :cond_2
    move-object v2, p1

    check-cast v2, Lcom/amazonaws/services/kms/model/CreateGrantRequest;

    .line 1293
    .local v2, "other":Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v0

    goto :goto_0

    :cond_3
    move v3, v1

    :goto_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_4

    move v4, v0

    goto :goto_1

    :cond_4
    move v4, v1

    :goto_1
    xor-int/2addr v3, v4

    if-eqz v3, :cond_5

    .line 1294
    return v1

    .line 1295
    :cond_5
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_6

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    .line 1296
    return v1

    .line 1297
    :cond_6
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_7

    move v3, v0

    goto :goto_2

    :cond_7
    move v3, v1

    :goto_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_8

    move v4, v0

    goto :goto_3

    :cond_8
    move v4, v1

    :goto_3
    xor-int/2addr v3, v4

    if-eqz v3, :cond_9

    .line 1298
    return v1

    .line 1299
    :cond_9
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_a

    .line 1300
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_a

    .line 1301
    return v1

    .line 1302
    :cond_a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_b

    move v3, v0

    goto :goto_4

    :cond_b
    move v3, v1

    :goto_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_c

    move v4, v0

    goto :goto_5

    :cond_c
    move v4, v1

    :goto_5
    xor-int/2addr v3, v4

    if-eqz v3, :cond_d

    .line 1303
    return v1

    .line 1304
    :cond_d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_e

    .line 1305
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_e

    .line 1306
    return v1

    .line 1307
    :cond_e
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_f

    move v3, v0

    goto :goto_6

    :cond_f
    move v3, v1

    :goto_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_10

    move v4, v0

    goto :goto_7

    :cond_10
    move v4, v1

    :goto_7
    xor-int/2addr v3, v4

    if-eqz v3, :cond_11

    .line 1308
    return v1

    .line 1309
    :cond_11
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_12

    .line 1310
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_12

    .line 1311
    return v1

    .line 1312
    :cond_12
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    if-nez v3, :cond_13

    move v3, v0

    goto :goto_8

    :cond_13
    move v3, v1

    :goto_8
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v4

    if-nez v4, :cond_14

    move v4, v0

    goto :goto_9

    :cond_14
    move v4, v1

    :goto_9
    xor-int/2addr v3, v4

    if-eqz v3, :cond_15

    .line 1313
    return v1

    .line 1314
    :cond_15
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    if-eqz v3, :cond_16

    .line 1315
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/kms/model/GrantConstraints;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_16

    .line 1316
    return v1

    .line 1317
    :cond_16
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_17

    move v3, v0

    goto :goto_a

    :cond_17
    move v3, v1

    :goto_a
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v4

    if-nez v4, :cond_18

    move v4, v0

    goto :goto_b

    :cond_18
    move v4, v1

    :goto_b
    xor-int/2addr v3, v4

    if-eqz v3, :cond_19

    .line 1318
    return v1

    .line 1319
    :cond_19
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-eqz v3, :cond_1a

    .line 1320
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1a

    .line 1321
    return v1

    .line 1322
    :cond_1a
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1b

    move v3, v0

    goto :goto_c

    :cond_1b
    move v3, v1

    :goto_c
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v4

    if-nez v4, :cond_1c

    move v4, v0

    goto :goto_d

    :cond_1c
    move v4, v1

    :goto_d
    xor-int/2addr v3, v4

    if-eqz v3, :cond_1d

    .line 1323
    return v1

    .line 1324
    :cond_1d
    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_1e

    invoke-virtual {v2}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1e

    .line 1325
    return v1

    .line 1326
    :cond_1e
    return v0
.end method

.method public getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;
    .locals 1

    .line 861
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->constraints:Lcom/amazonaws/services/kms/model/GrantConstraints;

    return-object v0
.end method

.method public getGrantTokens()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 972
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    return-object v0
.end method

.method public getGranteePrincipal()Ljava/lang/String;
    .locals 1

    .line 530
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->granteePrincipal:Ljava/lang/String;

    return-object v0
.end method

.method public getKeyId()Ljava/lang/String;
    .locals 1

    .line 349
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->keyId:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 1121
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getOperations()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 760
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    return-object v0
.end method

.method public getRetiringPrincipal()Ljava/lang/String;
    .locals 1

    .line 659
    iget-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->retiringPrincipal:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 5

    .line 1265
    const/16 v0, 0x1f

    .line 1266
    .local v0, "prime":I
    const/4 v1, 0x1

    .line 1268
    .local v1, "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    if-nez v3, :cond_0

    move v3, v4

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_0
    add-int/2addr v2, v3

    .line 1269
    .end local v1    # "hashCode":I
    .local v2, "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1270
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_1

    move v3, v4

    goto :goto_1

    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v1, v3

    .line 1271
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1272
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_2

    move v3, v4

    goto :goto_2

    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v2, v3

    .line 1273
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_3

    move v3, v4

    goto :goto_3

    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v1, v3

    .line 1274
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    .line 1275
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    if-nez v3, :cond_4

    move v3, v4

    goto :goto_4

    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/kms/model/GrantConstraints;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v2, v3

    .line 1276
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    mul-int/lit8 v1, v2, 0x1f

    .line 1277
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    if-nez v3, :cond_5

    move v3, v4

    goto :goto_5

    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v1, v3

    .line 1278
    .end local v2    # "hashCode":I
    .restart local v1    # "hashCode":I
    mul-int/lit8 v2, v1, 0x1f

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v3

    if-nez v3, :cond_6

    goto :goto_6

    :cond_6
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v4

    :goto_6
    add-int/2addr v2, v4

    .line 1279
    .end local v1    # "hashCode":I
    .restart local v2    # "hashCode":I
    return v2
.end method

.method public setConstraints(Lcom/amazonaws/services/kms/model/GrantConstraints;)V
    .locals 0
    .param p1, "constraints"    # Lcom/amazonaws/services/kms/model/GrantConstraints;

    .line 901
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->constraints:Lcom/amazonaws/services/kms/model/GrantConstraints;

    .line 902
    return-void
.end method

.method public setGrantTokens(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 997
    .local p1, "grantTokens":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 998
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    .line 999
    return-void

    .line 1002
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    .line 1003
    return-void
.end method

.method public setGranteePrincipal(Ljava/lang/String;)V
    .locals 0
    .param p1, "granteePrincipal"    # Ljava/lang/String;

    .line 571
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->granteePrincipal:Ljava/lang/String;

    .line 572
    return-void
.end method

.method public setKeyId(Ljava/lang/String;)V
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 416
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->keyId:Ljava/lang/String;

    .line 417
    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 1173
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->name:Ljava/lang/String;

    .line 1174
    return-void
.end method

.method public setOperations(Ljava/util/Collection;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 773
    .local p1, "operations":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    if-nez p1, :cond_0

    .line 774
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    .line 775
    return-void

    .line 778
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0, p1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    .line 779
    return-void
.end method

.method public setRetiringPrincipal(Ljava/lang/String;)V
    .locals 0
    .param p1, "retiringPrincipal"    # Ljava/lang/String;

    .line 700
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->retiringPrincipal:Ljava/lang/String;

    .line 701
    return-void
.end method

.method public toString()Ljava/lang/String;
    .locals 4

    .line 1243
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 1244
    .local v0, "sb":Ljava/lang/StringBuilder;
    const-string/jumbo v1, "{"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1245
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v1

    const-string v2, ","

    if-eqz v1, :cond_0

    .line 1246
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "KeyId: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getKeyId()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1247
    :cond_0
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 1248
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GranteePrincipal: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGranteePrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1249
    :cond_1
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 1250
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "RetiringPrincipal: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getRetiringPrincipal()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1251
    :cond_2
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_3

    .line 1252
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Operations: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1253
    :cond_3
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v1

    if-eqz v1, :cond_4

    .line 1254
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Constraints: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getConstraints()Lcom/amazonaws/services/kms/model/GrantConstraints;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1255
    :cond_4
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v1

    if-eqz v1, :cond_5

    .line 1256
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "GrantTokens: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1257
    :cond_5
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_6

    .line 1258
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Name: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1259
    :cond_6
    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 1260
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method public withConstraints(Lcom/amazonaws/services/kms/model/GrantConstraints;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .param p1, "constraints"    # Lcom/amazonaws/services/kms/model/GrantConstraints;

    .line 946
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->constraints:Lcom/amazonaws/services/kms/model/GrantConstraints;

    .line 947
    return-object p0
.end method

.method public withGrantTokens(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/CreateGrantRequest;"
        }
    .end annotation

    .line 1068
    .local p1, "grantTokens":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->setGrantTokens(Ljava/util/Collection;)V

    .line 1069
    return-object p0
.end method

.method public varargs withGrantTokens([Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 4
    .param p1, "grantTokens"    # [Ljava/lang/String;

    .line 1032
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getGrantTokens()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 1033
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    .line 1035
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 1036
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->grantTokens:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1035
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 1038
    :cond_1
    return-object p0
.end method

.method public withGranteePrincipal(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .param p1, "granteePrincipal"    # Ljava/lang/String;

    .line 617
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->granteePrincipal:Ljava/lang/String;

    .line 618
    return-object p0
.end method

.method public withKeyId(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .param p1, "keyId"    # Ljava/lang/String;

    .line 488
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->keyId:Ljava/lang/String;

    .line 489
    return-object p0
.end method

.method public withName(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .param p1, "name"    # Ljava/lang/String;

    .line 1230
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->name:Ljava/lang/String;

    .line 1231
    return-object p0
.end method

.method public withOperations(Ljava/util/Collection;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/kms/model/CreateGrantRequest;"
        }
    .end annotation

    .line 820
    .local p1, "operations":Ljava/util/Collection;, "Ljava/util/Collection<Ljava/lang/String;>;"
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->setOperations(Ljava/util/Collection;)V

    .line 821
    return-object p0
.end method

.method public varargs withOperations([Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 4
    .param p1, "operations"    # [Ljava/lang/String;

    .line 796
    invoke-virtual {p0}, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->getOperations()Ljava/util/List;

    move-result-object v0

    if-nez v0, :cond_0

    .line 797
    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    .line 799
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_1

    aget-object v2, p1, v1

    .line 800
    .local v2, "value":Ljava/lang/String;
    iget-object v3, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->operations:Ljava/util/List;

    invoke-interface {v3, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 799
    .end local v2    # "value":Ljava/lang/String;
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 802
    :cond_1
    return-object p0
.end method

.method public withRetiringPrincipal(Ljava/lang/String;)Lcom/amazonaws/services/kms/model/CreateGrantRequest;
    .locals 0
    .param p1, "retiringPrincipal"    # Ljava/lang/String;

    .line 746
    iput-object p1, p0, Lcom/amazonaws/services/kms/model/CreateGrantRequest;->retiringPrincipal:Ljava/lang/String;

    .line 747
    return-object p0
.end method
