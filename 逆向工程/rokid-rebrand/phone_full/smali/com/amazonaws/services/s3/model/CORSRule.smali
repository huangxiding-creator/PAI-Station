.class public Lcom/amazonaws/services/s3/model/CORSRule;
.super Ljava/lang/Object;
.source "CORSRule.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;
    }
.end annotation


# instance fields
.field private allowedHeaders:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private allowedMethods:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;",
            ">;"
        }
    .end annotation
.end field

.field private allowedOrigins:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private exposedHeaders:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private id:Ljava/lang/String;

.field private maxAgeSeconds:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getAllowedHeaders()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 208
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedHeaders:Ljava/util/List;

    return-object v0
.end method

.method public getAllowedMethods()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;",
            ">;"
        }
    .end annotation

    .line 79
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedMethods:Ljava/util/List;

    return-object v0
.end method

.method public getAllowedOrigins()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 113
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedOrigins:Ljava/util/List;

    return-object v0
.end method

.method public getExposedHeaders()Ljava/util/List;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 175
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->exposedHeaders:Ljava/util/List;

    return-object v0
.end method

.method public getId()Ljava/lang/String;
    .locals 1

    .line 46
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->id:Ljava/lang/String;

    return-object v0
.end method

.method public getMaxAgeSeconds()I
    .locals 1

    .line 141
    iget v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->maxAgeSeconds:I

    return v0
.end method

.method public setAllowedHeaders(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 193
    .local p1, "allowedHeaders":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedHeaders:Ljava/util/List;

    .line 194
    return-void
.end method

.method public varargs setAllowedHeaders([Ljava/lang/String;)V
    .locals 1
    .param p1, "allowedHeaders"    # [Ljava/lang/String;

    .line 201
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedHeaders:Ljava/util/List;

    .line 202
    return-void
.end method

.method public setAllowedMethods(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;",
            ">;)V"
        }
    .end annotation

    .line 64
    .local p1, "allowedMethods":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedMethods:Ljava/util/List;

    .line 65
    return-void
.end method

.method public varargs setAllowedMethods([Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;)V
    .locals 1
    .param p1, "allowedMethods"    # [Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;

    .line 72
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedMethods:Ljava/util/List;

    .line 73
    return-void
.end method

.method public setAllowedOrigins(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 97
    .local p1, "allowedOrigins":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedOrigins:Ljava/util/List;

    .line 98
    return-void
.end method

.method public varargs setAllowedOrigins([Ljava/lang/String;)V
    .locals 1
    .param p1, "allowedOrigins"    # [Ljava/lang/String;

    .line 105
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedOrigins:Ljava/util/List;

    .line 106
    return-void
.end method

.method public setExposedHeaders(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    .line 159
    .local p1, "exposedHeaders":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->exposedHeaders:Ljava/util/List;

    .line 160
    return-void
.end method

.method public varargs setExposedHeaders([Ljava/lang/String;)V
    .locals 1
    .param p1, "exposedHeaders"    # [Ljava/lang/String;

    .line 167
    invoke-static {p1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/CORSRule;->exposedHeaders:Ljava/util/List;

    .line 168
    return-void
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 39
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->id:Ljava/lang/String;

    .line 40
    return-void
.end method

.method public setMaxAgeSeconds(I)V
    .locals 0
    .param p1, "maxAgeSeconds"    # I

    .line 131
    iput p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->maxAgeSeconds:I

    .line 132
    return-void
.end method

.method public withAllowedHeaders(Ljava/util/List;)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/CORSRule;"
        }
    .end annotation

    .line 218
    .local p1, "allowedHeaders":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedHeaders:Ljava/util/List;

    .line 219
    return-object p0
.end method

.method public withAllowedMethods(Ljava/util/List;)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/CORSRule;"
        }
    .end annotation

    .line 89
    .local p1, "allowedMethods":Ljava/util/List;, "Ljava/util/List<Lcom/amazonaws/services/s3/model/CORSRule$AllowedMethods;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedMethods:Ljava/util/List;

    .line 90
    return-object p0
.end method

.method public withAllowedOrigins(Ljava/util/List;)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/CORSRule;"
        }
    .end annotation

    .line 123
    .local p1, "allowedOrigins":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->allowedOrigins:Ljava/util/List;

    .line 124
    return-object p0
.end method

.method public withExposedHeaders(Ljava/util/List;)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)",
            "Lcom/amazonaws/services/s3/model/CORSRule;"
        }
    .end annotation

    .line 185
    .local p1, "exposedHeaders":Ljava/util/List;, "Ljava/util/List<Ljava/lang/String;>;"
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->exposedHeaders:Ljava/util/List;

    .line 186
    return-object p0
.end method

.method public withId(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 56
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->id:Ljava/lang/String;

    .line 57
    return-object p0
.end method

.method public withMaxAgeSeconds(I)Lcom/amazonaws/services/s3/model/CORSRule;
    .locals 0
    .param p1, "maxAgeSeconds"    # I

    .line 151
    iput p1, p0, Lcom/amazonaws/services/s3/model/CORSRule;->maxAgeSeconds:I

    .line 152
    return-object p0
.end method
